## Mac Raspberry PI formatter

COMMAND LINE

If you are comfortable with the command line, you can write the image to a SD card without any additional software. Open a terminal, then run:

diskutil list

Identify the disk (not partition) of your SD card e.g. disk4, not disk4s1.
Unmount your SD card by using the disk identifier, to prepare for copying data to it:

diskutil unmountDisk /dev/disk<disk# from diskutil>

where disk is your BSD name e.g. diskutil unmountDisk /dev/disk4

Copy the data to your SD card:

sudo dd bs=1m if=image.img of=/dev/rdisk<disk# from diskutil>

where disk is your BSD name e.g. sudo dd bs=1m if=2016-05-27-raspbian-jessie.img of=/dev/rdisk4

This may result in a dd: invalid number '1m' error if you have GNU coreutils installed. In that case, you need to use a block size of 1M in the bs= section, as follows:

sudo dd bs=1M if=image.img of=/dev/rdisk<disk# from diskutil>

This will take a few minutes, depending on the image file size. You can check the progress by sending a SIGINFO signal (press Ctrl+T).

If this command still fails, try using disk instead of rdisk, for example:

sudo dd bs=1m if=2016-05-27-raspbian-jessie.img of=/dev/disk4
or

sudo dd bs=1M if=2016-05-27-raspbian-jessie.img of=/dev/disk4

## Connecting over SSH

ssh pi@192.168.1.177

If host key changes then do the following

ssh-keygen -R 192.168.1.177

## Update Raspberry Pi

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install rpi-update
sudo rpi-update

sudo apt-get clean

## Bluetooth on RPi 3

systemctl status bluetooth

