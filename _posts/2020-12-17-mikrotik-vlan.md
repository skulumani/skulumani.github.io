---
layout: post
title: "Mikrotik VLAN - IOT Isolation"
date: 2020-12-17
tags: [boinc,linux]
excerpt: "Adding boot entries to PopOS boot menu"
---

# Terms

VLAN enabled ports are generally categorized in one of two ways, tagged or untagged. These may also be referred to as "trunk" or "access" respectively. The purpose of a tagged or "trunked" port is to pass traffic for multiple VLAN's, whereas an untagged or "access" port accepts traffic for only a single VLAN. Generally speaking, trunk ports will link switches, and access ports will link to end devices.

1. Add VLAN interfaces

2. Add IP address gateway

3. IP Pool - set gateway to match above. 

4. DHCP Network -  Set DNS servers, Google and Cloudflare

3. DHCP server - use pool.

Switch settings - PVID and tagged/untagged
Firewall rules

# References

https://www.manitonetworks.com/mikrotik/2016/3/5/vlan-trunking

https://www.tp-link.com/us/support/faq/418/

https://documentation.meraki.com/General_Administration/Tools_and_Troubleshooting/Fundamentals_of_802.1Q_VLAN_Tagging
