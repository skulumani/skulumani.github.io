---
layout: post
title: "Mikrotik VLAN - IOT Isolation"
date: 2020-12-17
tags: [network,linux]
excerpt: "Network isolation using Mikrotik VLANs"
published: true
---

This is a summary of setting up VLANs in order to isolate my smart devices. 
The instructions here can be used for any other similar purpose to organize a home network.
The goal is to allow these devices internet connectivity, but deny access to my personal devices. 

In order to allow this network isolation the goal is to create dedicated virtual LANs for each type of device, then utilize a firewall to prevent traffic between these two.

* Trusted VLAN ID 100 - Trusted wireless devices on 5GHz and those connected via ethernet. In addition, any devices on the default VLAN ID 1 are able to communicate with this VLAN.
* Untrusted VLAN ID 200 - All devices connected over 2.4GHz. Luckily most IOT devices only support 2.4GHz which makes this straightforward. Another benefit is these devices don't slow downthe network for others.


## Hardware

* [Mikrotik hap ac2](https://mikrotik.com/product/hap_ac2) - Home router. Tiny device with enterprise level capabilities. These devices are so capable many run entire community ISPs using  Mikrotik hardware. Also, all Mikrotik devices run RouterOS, so the same techniques used for an ISP on enterprise grade hardware will work on this home device.
* [Netgear GS108PE](https://www.netgear.com/business/wired/switches/smart-managed-plus/gs108pe) - POE switch for wireless access points and security cameras. It's important to utilize a "smart" switch or one that is VLAN aware or else much of the following may not work. In addition, this switch provides 4 powered ports and 3 unpowered gigabit ethernet ports. 
* [TP-Link EAP 225](https://www.tp-link.com/us/business-networking/ceiling-mount-access-point/eap225/) - Business grade wireless access points. Allows for multiple SSIDs and VLAN configuration. Much better than any consumer grade wireless router and by using a wired backhaul the performance/capabilities are much better than any consumer grade "mesh" system.

## Defining VLANs

First, we need to actually define and setup DHCP for our VLANs. 
Without this step, the clients will be unable to even connect to our router or the internet.

1. Define VLANs on `Interfaces > VLAN` menu using either the web configuration or Winbox. 
Ensure you define the correct interface that is physically connected to the switch. 
This is `ether5` in my case. 
Finally, define the desired VLAN ID for each VLAN. 
Later, on the switch we'll set the VLAN ID for specific ports or specific wireless networks.
This will define a special VLAN tag on every associated packet that the router will use to correctly route data to the appropriate VLAN.
* VLAN 100 - Trusted wireless network
* VLAN 200 - Untrusted wireless network (IOT devices)
![vlan100](/assets/vlan/vlan100.png)
![vlan](/assets/vlan/vlan_interfaces.png)

2. Add IP address gateway - on the `IP > Addresses` we next need to define the gateway address for each VLAN interface. 
Use the plus button, and add a gateway
* VLAN 100 - use `192.168.100.1/24` on interface `vlan100` from the previous step
* VLAN 200 - use `192.168.200.1/24` on interface `vlan200` from the previous step
By default we already have the `192.168.88.1/24` network for everything else. 
![address list](/assets/vlan/address_list.png)

3. IP Pool - Now we define a "pool" of addresses for each VLAN, and the subsequent DHCP server. 
This is basically defining the set of addresses that can be assigned to each VLAN. 
Go to the `IP > Pool` menu and define a pool for each
* VLAN 100 - Pool of `192.168.100.20-192.168.100.254`
* VLAN 200 - Pool of `192.168.200.20-192.168.200.254`
I usually ensure there are a few IPs available for static leases that will never be assigned dynamically by the DHCP.
![ip pool](/assets/vlan/ip_pool.png)

4. DHCP Network - Now on the `IP > DHCP Server > Networks` menu we define the DHCP network for each VLAN. 
Also here is where we define the DNS servers for the network. 
* VLAN 100 - Address `192.168.100.0/24` and gateway of `192.168.100.1` same as defined above
* VLAN 200 - Address `192.168.200.0/24` and gateway of `192.168.200.1` same as defined above
I utilize both [Cloudflare](https://1.1.1.1/dns/) and [Google](https://developers.google.com/speed/public-dns) DNS servers for extra redudancy and speed. 
* Cloudflare - `1.1.1.1` and `1.0.0.1`
* Google - `8.8.8.8` and `8.8.4.4`
![dhcp network](/assets/vlan/dhcp_network.png)

5. DHCP server - Now define the DHCP servers on the `IP > DHCP Server > DHCP` menu to distribute addresses to clients on each VLAN. 
Our servers will utilize the IP pools we defined previously.
![dhcp_server](/assets/vlan/dhcp_server.png)

Now we have two VLANs and a DHCP server for each. 
Any packet tagged with a VLAN ID of 100 or 200 will be routed to the respective interface, then be  assigned an IP from the respective DHCP server.
Next, we need to configure the switch and wireless access points to set the VLAN ID on specific clients.

## Switch and EAP 225 configuration

Configuring the switch was one of the more confusing aspects of this whole process for me. 
On the router we defined some network settings to handle packets tagged with a specific VLAN ID. 
However, we still haven't defined how these tags are actually defined. 
This is where the switch comes into play. 
Since this is a "smart" switch we can set a specific VLAN ID for each port of the switch, or we can allow a port to pass data that is already tagged, such as from our wireless access points. 

1. Define VLANs -  Navigate to the `VLAN > 802.1Q > Advanced > VLAN Configuration` menu on the switch. 
This web  configuration tool is not well defined but you can create new VLANs by adding the desired ID and then clicking `ADD` at the top right. 
Add two VLANs for our desired setup.
![vlan configuration](/assets/vlan/vlan_configuration.png)

2. VLAN membership - Now go to the `VLAN > 802.1Q > Advanced > VLAN Membership` and assign each physical port of the switch  to a VLAN.  
Ports can either be "Tagged" (or also known as trunk) or "Untagged" (or also known as access) ports. 
* Tagged - Allows traffic for multiple VLANs
* Untagged - allows traffic for only a single VLAN
![vlan 100](/assets/vlan/vlan_100_membership.png)
![vlan 200](/assets/vlan/vlan_200_membership.png)
In my case, I set the following
* Ports 1 and 2 are connected to my wireless access points. These will be passing both VLAN 100 and VLAN 200 traffic so they are "Tagged" ports and members of both VLANs.
* Ports 3 and 4 are connected to POE security cameras. They are set as "Untagged" ports since they will pass only a single VLAN traffic data. 
* Port 6 - Connected to a home server. I added it as a member of both VLANs but this is not strictly necessary. Especially since our firewall later will not allow traffic. 
* Port 8 - This port connects back to the router on `ether5` and is also a "Tagged" port since it's passing traffic for multiple VLANs.

3. VLAN PVID - Finally we set the actual VLAN ID for  ports. Go to `VLAN > 802.1Q > Advanced > Port PVID` and set the PVID for the desired ports. Port 3 and 4 will now always be passing only VLAN 200 traffic and nothing else. 
![vlan pvid](/assets/vlan/vlan_pvid.png)

If desired, you can set the PVID for other wired clients. 
In my case, I will let the wireless access point define the VLAN ID and just let the switch pass the data.

All the other ports will have VLAN ID 1 by default. 
This will then utilize the default `192.168.88.0/24` DHCP network on the router. 

## Wireless access points

The [EAP 225](https://www.tp-link.com/us/business-networking/ceiling-mount-access-point/eap225/) are very powerful wireless access points and offer a large variety of features which are far beyond any consumer combinationo router/wireless access point.
In addition, one can also run the [Omada](https://www.tp-link.com/us/omada/) software are easily manage the access points. 

For each Wireless SSID, we simply  define the desired VLAN ID.

![omada](/assets/vlan/omada.png)
![omada](/assets/vlan/wireless_vlan.png)

* VLAN 100 - Wireless 5GHz network for "trusted" devicessuch as smart phones and laptops
* VLAN 200 - Wireless 2.4GHz network for all the IOT/smart devices. This includes TVs, Google Home, Alexa, light bulbs, thermostats, sensors, etc. 
* VLAN 200 - Wireless guest network gets dumped into this untrusted network as well. I also rate limit the guest network. Staying with me is like staying at the Mariott. If you want fast internet, you need to pay extra. 

## Firewall for VLAN isolation

All of this has created 2 dedicated VLANs. 
Clients connecting to the VLAN will be assigned specific IP address by the respective DHCP server. 
The router will happily route traffic between the VLANs by default, and here is where we put a stop to that. 
In general, I want to  still be able to access the "Untrusted" network.
We would like to control the smart devices, access the security cameras, or enable my Home Assistant instance to gather that data.
However, we do not allow any traffic from the "Untrusted" network back to the "Trusted" side. 
We'll utilize a type of "zone based" firewall to enable this type of network isolation

1. Address list - We define two address lists for ease of configuration. This is under the `IP > Firewall > Address Lists` menu. You can use this menu to define groups of addresses for later use by the firewall. 
This eases the configuration by letting us group related addresses into a single "zone".
* Trusted - Includes all clients within `192.168.100.0/24` and `192.168.88.0/24` networks
* Untrusted - All VLAN 200 devices with addresses `192.168.200.0/24`
![firewall address list](/assets/vlan/firewall_address_list.png)
2. Firewall rule - Now on the `IP > Firewall > Filter Rule` we finally set the rule to isolate our "Untrusted" VLAN. Add two rules with the following (and extend to your use case):
* Accept traffic on the forward chain from "Trusted" to "Untrusted". 
* Deny traffic on the forward chain from "Untrusted" to "Trusted".
![firewall filter](/assets/vlan/firewall_rule.png)

With these two simple rules, clients on the VLAN 200 network are completely unable to communicate with the "Trusted" network. 
This is easily tested by using `nmap` or a simple `ping`.

# References

* [VLAN Trunking](https://www.manitonetworks.com/mikrotik/2016/3/5/vlan-trunking)
* [Tagged vs. Untagged](https://www.tp-link.com/us/support/faq/418/)
* [VLAN Tagging](https://documentation.meraki.com/General_Administration/Tools_and_Troubleshooting/Fundamentals_of_802.1Q_VLAN_Tagging)
* [NMAP](https://www.manitonetworks.com/security/2016/11/26/network-scanning-with-nmap?rq=nmap)
