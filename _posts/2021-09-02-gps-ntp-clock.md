---
layout: post
title: "Precision time using GPS/PPS and NTP"
date: 2021-09-18
tags: [linux]
excerpt: "Setting up an stratum 1 NTP server on a Raspberry Pi"
published: true
---
# Purpose

Need accurate time
# Parts List

|-------|----------------|
| [RapsberryPi Zero W]() | |
| [GPS Module](https://smile.amazon.com/Microcontroller-Compatible-Sensitivity-Navigation-Positioning/dp/B07P8YMVNT/ref=sr_1_3?dchild=1&keywords=gps%2Bmodule&qid=1630621465&sr=8-3&th=1#) | |
| [RTC](https://www.adafruit.com/product/3295) | |
| [LCD Screen]() | |
| Case |
| Jumper wires | |
| Header Pins | |
| SD Card | |

# Wiring 

Solder header pins onto the boards. 

Adafruit soldering guide.

Board operates on 3.3 volts, but there is a voltage regulator that allows power from the 5V USB.
The TXD, RXD, and PPS pins operate at 3.3V and are not 5V tolerant.
The RapsberryPi GPIO pins operate such that 3.3V are considered high.

|-------------|------------------|
| GPS | RPi |
|-----|-----|
| PPS | GPIO4 Pin 7 |
| TXD | GPIO15 Pin 10 |
| RXD | GPIO14 Pin 8 |
| GND | Ground Pin 6 |
| VCC | 3.3V Pin 1 or 5V Pin 2|


Now that the components are wired up we're going set up a few pieces of software:

1. Basic Raspberry Pi setup
2. GPS and PPS setup
3. NTP Setup
4. SNMP Setup
5. Simple Apache webserver
6. MRTG Plotting 

# Basic Raspberry Pi Setup

1. Install raspbian 
2. [Headless](https://www.raspberrypi.org/documentation/computers/configuration.html#setting-up-a-headless-raspberry-pi)

Create a file `wpa_supplicant.conf` and place into boot folder on SD card.

~~~
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=US

network={
        scan_ssid=1
        ssid="<Name of your wireless LAN>"
        psk="<Password for your wireless LAN>"
        proto=RSN
        key_mgmt=WPA-PSK
        pairwise=CCMP
        auth_alg=OPEN
}
~~~

Add `ssh.txt` to boot folder as well for SSH access

3. Initial setup
* Change default password
* Update
* Disable serial  terminal - `sudo raspi-config` Interface Options - Serial Port 
    * Would you like login shell to be accessible over serial - No
    * Would you like serial port hardware to be enabled? - Yes

~~~
sudo systemctl stop serial-getty@ttyAMA0.service
sudo systemctl stop serial-getty@ttyAMA0.service
sudo systemctl disablel hciuart
~~~

Install software
~~~
sudo apt-get install gpsd gpsd-clients pps-tools vim
~~~

Add following to `/boot/config.txt`

~~~
dtoverlay=pi3-disable-bt

# enable PPS
dtoverlay=pps-gpio,gpiopin=18
~~~

Add following to `/etc/modules`
~~~
pps-gpio
~~~

Test the GPS is working by reading the output:
~~~
cat /dev/ttyAMA0 
~~~

You should see something like this to know GPS is working:
~~~
$GPGGA,023938.00,3857.28466,N,07701.04450,W,2,08,1.02,60.6,M,-34.7,M,,0000*5B

$GPGSA,A,3,31,26,04,27,16,03,22,09,,,,,1.88,1.02,1.58*06

$GPGSV,3,1,12,03,23,233,25,04,60,302,17,08,09,184,09,09,24,315,25*70

$GPGSV,3,2,12,16,84,246,31,22,12,216,22,26,56,047,24,27,30,162,30*76

$GPGSV,3,3,12,29,05,031,,31,29,085,29,46,20,244,,51,35,223,32*7B
~~~

Check if PPS module is loaded using `lsmod | grep pps`

Test PPS with `pptest /dev/pps0`

~~~
sudo apt-get install gpsd gpsd-clients pps-tools vim
~~~



Now install `gpsd` daemon to parse the NMEA GPS data

~~~
sudo apt-get install gpsd gpsd-clients
~~~

Edit the daemon to use proper serial device
~~~
sudo vim /etc/default/gpsd
~~~

Change following values
~~~
START_DAEMON="true"
USBAUTO="false"
DEVICES="/dev/ttyAMA0 /dev/pps0"
GPSD_OPTIONS="-n"
~~~

Move PPS and GPS devices to `dialout` group
~~~
sudo chown root.dialout /dev/pps0
sudo chown root.dialout /dev/ttyAMA0
sudo usermod -a -G dialout pi
~~~

Enable gpsd systemd service
~~~
sudo systemctl daemon-reload
sudo systemctl enable gpsd
sudo systemctl start gpsd
~~~

Check `gpsd` status with `systemctl status gpsd`

Now check gps with `gpsmon` and see something like this:
Or try `cgps -s`
~~~
──────────────────────────────────────────────────────────────────────────────
/dev/ttyAMA0                  u-blox>
┌──────────────────────────┐┌─────────────────────────────────────────────────┐
│Ch PRN  Az  El S/N Flag U ││ECEF Pos: < redacted>m -<redacted >m +<redacted>m│
│ 0   3 224  13  15 040e   ││ECEF Vel:     +0.01m/s     -0.01m/s     +0.05m/s │
│ 1   4 278  68  30 040f Y ││                                                 │
│ 2   7 291   8  14 0404   ││LTP Pos:  38° -77°    70.88m                     │
│ 3   8 182  21  19 040f Y ││LTP Vel:    0.03m/s  13.5°   0.04m/s             │
│ 4   9 311  35  20 040f Y ││                                                 │
│ 5  16  14  80  18 040f Y ││Time: 61 <redacted>                              │
│ 6  18  70   1   0 0104   ││Time GPS: 2175+<redacted>.000     Day: 6         │
│ 7  22 208   3  11 040e   ││                                                 │
│ 8  26  50  44  29 040f Y ││Est Pos Err  11.97m Est Vel Err   0.00m/s        │
│ 9  27 156  43  35 070f Y ││PRNs:  8 PDOP:  2.1 Fix 0x03 Flags 0xdf          │
│10  31  95  20  29 040f Y │└─────────────────── NAV_SOL ─────────────────────┘
│11 131 233  29   0 0004   │┌─────────────────────────────────────────────────┐
│12 133 244  20   0 0104   ││DOP [H]  1.1 [V]  1.9 [P]  2.1 [T]  1.3 [G]  2.5 │
│13 135 247  17   0 0110   │└─────────────────── NAV_DOP ─────────────────────┘
│14 138 223  35  32 060f Y │┌─────────────────────────────────────────────────┐
│15 193   0 165   0 0110   ││TOFF:  0.166813270       PPS:  0.009975908       │
└────── NAV_SVINFO ────────┘└─────────────────────────────────────────────────┘
~~~

# NTP Server

Disable NTP in DHCP (don't get time from network)

Edit `/etc/dhcp/dhclient.conf` and remove `sntp-servers` and `ntp-servers`

Delete following files

~~~
/etc/dhcp/dhclient-exit-hooks.d/ntp
/lib/dhcpd/dhcpcd-hooks/50-ntp.conf
~~~

Add the following lines to `/etc/ntp.conf`

Add PPS server to NTP. This one is using the kernel PPS driver. 

~~~
server 127.127.22.0 minpoll 4 maxpoll 4
fudge 127.127.22.0 refid PPS
~~~

Add GPS server to NTP

~~~
server 127.127.28.0 minpoll 4 maxpoll 4 
fudge 127.127.28.0 time1 +0.000 refid GPS
~~~


Shared memory PPS 

~~~
server 127.127.28.2 minpoll 4 maxpoll 4
fudge 127.127.28.2 refid SHM2
~~~

Determine offset between the PPS pulse and the GPS data from the serial port

Disable GPS but monitor
~~~
server 127.127.28.0 minpoll 4 maxpoll 4 noselect
fudget 127.127.28.0 time1 0.000 refid GPSD
~~~

Now watch output of `ntpq -pn` and look at offset for server with refid GPSD.
Then use that value in the server config, assume 130ms. 
If the offset is negative, then the config should be positive (opposite).

~~~
server 127.127.28.0 minpoll 4 maxpoll 4 prefer
fudge 127.127.28.0 time1 0.130 refid GPSD
~~~

Can also do this automatically by using some unix magic
This will grep the output of `ntpq` and look for the line with our GPS device only when it updates (when t column goes to 1), then append that to the end of the file.

~~~
watch -n 0.5 "ntpq -pn | grep -E '.GPS. +0 +l +1 ' | tee --append gpsd_offset.txt"
~~~

Once it's run for a long time (days or so) then compute the mean offset using the following:

~~~
awk '{total=total+$9; count=count+1} END {print "Total:"total; print "Count:"count; print "Avg:"total/count}' gps_offset.txt
~~~

Then just update the ntp configuration at `/etc/ntp.conf` with the offset (don't forget to swap sign)

## Performance monitoring NTP

NTP offers a large variety of [logging functionality](https://docs.ntpsec.org/latest/monopt.html#statistics).

Enable [statistics](http://www.ntp.org/ntpfaq/NTP-s-trouble.htm) logging within NTP by modifying the `ntp.conf` configuration.
Make sure the `statsdir` exists ahead of time using `mkdir -p /home/pi/ntpstats/` and also always use the full path.

~~~
statsdir /home/pi/ntpstats/
statistics loopstats peerstats clockstats

filegen loopstats file loopstats type day enable
filegen peerstats file peerstats type day enable
filegen clockstats file clockstats type day enable
~~~

Plot the statistics
Send stats out over SNMP
Generate plots using MRTG

# [SNMP](https://www.satsignal.eu/raspberry-pi/monitoring.html#ntp)

For remote monitoring: 
~~~
sudo apt-get update
sudo apt-get install snmpd snmp
~~~

Change config for remote access `sudo vim /etc/snmp/snmpd.conf`
Change `agentAddress udp:127.0.0.1:161` to `agentAddress udp:161,udp6:[::1]:161`

Add `rocommunity public` below the line `#rocommunity public localhost`

Restart SNMP daemon `sudo service snmpd restart`

Can verify it's working by the following

~~~
snmpwalk -Os -c public -v 2c localhost 1.3.6.1.4.1.2021.10.1.3.1
~~~
which should show the 1 minute load.

Also can walk through all OIDs using the following:

~~~
snpwalk -c public -v 1 localhost .1.3 > /tmp/oids.txt
~~~

There are lots of OIDs, some examples are below for raspbian buster

* 1 minute CPU Load: `1.3.6.1.4.1.2021.10.1.3.1`
* 5 minute CPU Load: `1.3.6.1.4.1.2021.10.1.3.2`
* 15 minute CPU Load: `1.3.6.1.4.1.2021.10.1.3.3`
* Idle CPU Time (%): `1.3.6.1.4.1.2021.11.11.0`
* Total RAM: `1.3.6.1.4.1.2021.4.5.0`
* Total RAM used: `1.3.6.1.4.1.2021.4.6.0`
* Total RAM free: `1.3.6.1.4.1.2021.4.11.0`
* Total disk/partition size (kbytes): `1.3.6.1.4.1.2021.9.1.6.1`
* Available space on disk: `1.3.6.1.4.1.2021.9.1.7.1`
* Used space on disk: `1.3.6.1.4.1.2021.9.1.8.1`

# MRTG

Run `setup_mrtg.sh` script

MRTG can monitor other data not provided by SNMP directly using an external script. 
It is documented [here](https://oss.oetiker.ch/mrtg/doc/mrtg-reference.en.html).
The external script just needs to return 4 lines of output defined below:
    * Line 1 Current state of first variable, normally `incoming bytes count`
    * Line 2 Current state of second variable, normally `outgoing bytes count`
    * Line 3 String (in any human readable format), telling the uptime of target
    * Line 4 string, name of the target
An example `mrtg` target is below
~~~
Target[ex]: `bash /home/pi/script.sh`
~~~
Make sure to use backticks, not apostrophes

## Parsing GPS for use in MRTG

Pipe `gpspipe -w` to Python then parse the JSON, then output into a MRTG compatible format


# Basic Apache2 webserver

Run the `setup_apache.sh` script. 
This creates a website in `/home/pi/www` where you can add any html pages for display

Some other tutorials on setting up an Apache2 webserver on a Raspberry Pi

* [Pi my Life up](https://pimylifeup.com/raspberry-pi-apache/https://pimylifeup.com/raspberry-pi-apache/)

# Reference

* [PCF8523](https://learn.adafruit.com/adafruit-pcf8523-real-time-clock)
* [Ulitmate GPS](https://learn.adafruit.com/adafruit-ultimate-gps)
* [GT-U7 Manual](https://m.media-amazon.com/images/I/91tuvtrO2jL.pdf)
* [NTP](https://www.satsignal.eu/ntp/Raspberry-Pi-NTP.html)
* [Johanees Weber NTP via GPS](https://weberblog.net/ntp-server-via-gps-on-a-raspberry-pi/)
* [David Taylor NTP](https://www.satsignal.eu/ntp/Raspberry-Pi-NTP.html)
