

After removing one drive

~~~
[I] ➜ zpool status           
  pool: data
 state: DEGRADED
status: One or more devices could not be used because the label is missing or
	invalid.  Sufficient replicas exist for the pool to continue
	functioning in a degraded state.
action: Replace the device using 'zpool replace'.
   see: http://zfsonlinux.org/msg/ZFS-8000-4J
  scan: scrub repaired 0B in 0 days 02:28:25 with 0 errors on Fri Feb  4 18:31:35 2022
config:

	NAME                                           STATE     READ WRITE CKSUM
	data                                           DEGRADED     0     0     0
	  mirror-0                                     DEGRADED     0     0     0
	    ata-WDC_WD5000AADS-00S9B0_WD-WCAV90314351  ONLINE       0     0     0
	    8834335926381272963                        UNAVAIL      0     0     0  was /dev/disk/by-id/ata-WDC_WD10EARX-00N0YB0_WD-WMC0S0561306-part1

errors: No known data errors
~~~

list the disks by id

~~~
[I] ➜ ls -l /dev/disk/by-id
total 0
lrwxrwxrwx 1 root root  9 Feb  4 21:05 ata-KINGSTON_SA400S37240G_50026B77826D8812 -> ../../sda
lrwxrwxrwx 1 root root 10 Feb  4 21:05 ata-KINGSTON_SA400S37240G_50026B77826D8812-part1 -> ../../sda1
lrwxrwxrwx 1 root root 10 Feb  4 21:05 ata-KINGSTON_SA400S37240G_50026B77826D8812-part2 -> ../../sda2
lrwxrwxrwx 1 root root 10 Feb  4 21:05 ata-KINGSTON_SA400S37240G_50026B77826D8812-part5 -> ../../sda5
lrwxrwxrwx 1 root root  9 Feb  4 21:05 ata-MG04ACA600E_Y699K0Y9FJZC -> ../../sdc
lrwxrwxrwx 1 root root  9 Feb  4 21:05 ata-WDC_WD5000AADS-00S9B0_WD-WCAV90314351 -> ../../sdb
lrwxrwxrwx 1 root root 10 Feb  4 21:05 ata-WDC_WD5000AADS-00S9B0_WD-WCAV90314351-part1 -> ../../sdb1
lrwxrwxrwx 1 root root 10 Feb  4 21:05 ata-WDC_WD5000AADS-00S9B0_WD-WCAV90314351-part9 -> ../../sdb9
lrwxrwxrwx 1 root root  9 Feb  4 21:05 wwn-0x500003976bb00fc7 -> ../../sdc
lrwxrwxrwx 1 root root  9 Feb  4 21:05 wwn-0x50014ee101fd62c0 -> ../../sdb
lrwxrwxrwx 1 root root 10 Feb  4 21:05 wwn-0x50014ee101fd62c0-part1 -> ../../sdb1
lrwxrwxrwx 1 root root 10 Feb  4 21:05 wwn-0x50014ee101fd62c0-part9 -> ../../sdb9
lrwxrwxrwx 1 root root  9 Feb  4 21:05 wwn-0x50026b77826d8812 -> ../../sda
lrwxrwxrwx 1 root root 10 Feb  4 21:05 wwn-0x50026b77826d8812-part1 -> ../../sda1
lrwxrwxrwx 1 root root 10 Feb  4 21:05 wwn-0x50026b77826d8812-part2 -> ../../sda2
lrwxrwxrwx 1 root root 10 Feb  4 21:05 wwn-0x50026b77826d8812-part5 -> ../../sda5
~~~

Replace the disk

[I] ➜ sudo zpool replace -f data 8834335926381272963 ata-MG04ACA600E_Y699K0Y9FJZC
~~~

Let zfs resliver the drive

~~~
[I] ➜ zpool status
  pool: data
 state: DEGRADED
status: One or more devices is currently being resilvered.  The pool will
	continue to function, possibly in a degraded state.
action: Wait for the resilver to complete.
  scan: resilver in progress since Fri Feb  4 21:18:01 2022
	34.2G scanned at 834M/s, 468K issued at 11.1K/s, 364G total
	0B resilvered, 0.00% done, no estimated completion time
config:

	NAME                                           STATE     READ WRITE CKSUM
	data                                           DEGRADED     0     0     0
	  mirror-0                                     DEGRADED     0     0     0
	    ata-WDC_WD5000AADS-00S9B0_WD-WCAV90314351  ONLINE       0     0     0
	    replacing-1                                DEGRADED     0     0     0
	      8834335926381272963                      UNAVAIL      0     0     0  was /dev/disk/by-id/ata-WDC_WD10EARX-00N0YB0_WD-WMC0S0561306-part1
	      ata-MG04ACA600E_Y699K0Y9FJZC             ONLINE       0     0     0

errors: No known data errors
~~~

~~~

Wait unit resilvering is completed

~~~
[I] ➜ zpool status
  pool: data
 state: DEGRADED
status: One or more devices is currently being resilvered.  The pool will
	continue to function, possibly in a degraded state.
action: Wait for the resilver to complete.
  scan: resilver in progress since Fri Feb  4 21:18:01 2022
	364G scanned at 66.1M/s, 80.8G issued at 14.7M/s, 364G total
	81.0G resilvered, 22.19% done, 0 days 05:29:30 to go
config:

	NAME                                           STATE     READ WRITE CKSUM
	data                                           DEGRADED     0     0     0
	  mirror-0                                     DEGRADED     0     0     0
	    ata-WDC_WD5000AADS-00S9B0_WD-WCAV90314351  ONLINE       0     0     0
	    replacing-1                                DEGRADED     2     0     0
	      8834335926381272963                      UNAVAIL      0     0     0  was /dev/disk/by-id/ata-WDC_WD10EARX-00N0YB0_WD-WMC0S0561306-part1
	      ata-MG04ACA600E_Y699K0Y9FJZC             ONLINE       0     0     2  (resilvering)

errors: No known data errors
~~~

