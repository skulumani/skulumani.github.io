---
layout: post
title: "Dual Boot PopOS"
date: 2020-12-16
tags: [boinc,linux]
excerpt: "Adding boot entries to PopOS boot menu"
---

PopOS uses `systemd-boot` for startup instead of `grub`. 
As a result, modifying the boot menu is slightly different. 

# Setup multiple boot

It generally recommended to install each OS on a dedicated drive. 
Furthermore, when installing the OS, you can physically disconnect any extra drives to ensure that Windows, PopOS or any other OS doesn't accidently  corrupt your data/EFI partitions. 
This is especially recommended when dealing with Windows. 

In all cases, it's ideal to install Windows first followed by Linux distributions. 

# Modify boot menu

Assuming you're using PopOS, or another OS that utilizes `systemd-boot`, you can add an additional OS to the boot menu as follows:

1. Add timeout so the menu appears. Edit `/boot/efi/loader/loader.conf` and add the following 
~~~
timeout 5
~~~
For a 5 second timeout

2. Mount the windows (or any other OS) EFI partition. You can list the partions using `sudo fdisk -l`. 
Look for partitions of type `EFI  System`, you should have at least 1 or more for each OS you have available. 


![fdisk](/assets/fdisk.png)

In this case, I want to mount the Windows EFI partition located at `/dev/sda1`

3. Mount the partition to a temporary folder

~~~
mkdir /tmp/efi_partition
sudo mount /dev/sda1 /tmp/efi_partition
~~~

4. Within this mount you will locate a folder with the name of the OS (`Microsoft` in this case) you need to copy this to the PopOS EFI partition

~~~
sudo cp -R /tmp/efi_partition/Microsoft /boot/efi/EFI
~~~

Now you can chose the OS to boot. 

# References

* [Reddit Post](https://www.reddit.com/r/pop_os/comments/gjsr6r/psa_how_to_dual_boot_pop_os_with_windows_with_a/)
