
# Purpose

# Parts List

|-------|----------------|
| [RapsberryPi Zero W]() | |
| [GPS Module](https://smile.amazon.com/Microcontroller-Compatible-Sensitivity-Navigation-Positioning/dp/B07P8YMVNT/ref=sr_1_3?dchild=1&keywords=gps%2Bmodule&qid=1630621465&sr=8-3&th=1#) | |
| [RTC](https://www.adafruit.com/product/3295) | |

# RPi setup

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

3. Disable serial terminal for use by GPS

# Wiring 

Board operates on 3.3 volts, but there is a voltage regulator that allows power from the 5V USB.
The TXD, RXD, and PPS pins operate at 3.3V and are not 5V tolerant.
The RapsberryPi GPIO pins operate such that 3.3V are considered high.

|-------------|------------------|
| GPS | RPi |
| PPS | GPIO4 Pin 7|
| TXD | GPIO15 Pin 10 |
| RXD | GPIO14 Pin 8 |
| GND | Ground Pin 6 |
| VCC | 3.3V Pin 1 or 5V Pin 2|

# Reference

* [PCF8523](https://learn.adafruit.com/adafruit-pcf8523-real-time-clock)
* [Ulitmate GPS](https://learn.adafruit.com/adafruit-ultimate-gps)
* [GT-U7 Manual](https://m.media-amazon.com/images/I/91tuvtrO2jL.pdf)
* [NTP](https://www.satsignal.eu/ntp/Raspberry-Pi-NTP.html)
*
