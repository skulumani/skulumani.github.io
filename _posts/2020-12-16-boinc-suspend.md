---
layout: post
title: "BOINC GPU suspend on Linux"
date: 2020-12-16
tags: [boinc,linux]
excerpt: "Properly suspend GPU  usage on Linux"
---

# Introduction

[BOINC](https://boinc.berkley.edu) is a platform to allow participants to provide home computational resources to a wide variety of scientific [research projects](https://boinc.berkeley.edu/projects.php).
It's frequently useful to utilize a BOINC account manager to easily handle project/work related settings across multiple devices. 
For example, I utilize [BOINCStats](https://www.boincstats.com/) and you can see my credit history [here](https://www.boincstats.com/stats/-5/user/detail/6139177909af1e2fe15dc658dfba058f). 

![BOINC Credits](https://www.boincstats.com/signature/-5/user/15232664863/sig.png)

# Efficiently using GPU

BOINC can utilize both your CPU and GPU to perform research. 
BOINC by default runs at a lower priority such that other applications will typically not be affected by BOINC during normal use. 
In addition, BOINC can be set to only utilize these resources when the [system is idle](https://boinc.berkeley.edu/wiki/Client_configuration#Command-line_options). 
However, in my experience on Linux the detection of idle system state does not correctly allow the GPU to be utilized. 
As a result, one can execute the following [bash script](https://github.com/skulumani/system_setup/blob/master/dotfiles/bin/boinc_gpu_suspend.sh), either manually or on startup, to ensure the GPU is used when idle.


~~~
#!/bin/bash

gdbus monitor --session --dest org.gnome.SessionManager --object-path /org/gnome/SessionManager/Presence | 
while read -r sig; do
    case $sig in
        *StatusChanged*3,\)) boinccmd --set_gpu_mode always;;
        *StatusChanged*) boinccmd --set_gpu_mode auto;;
    esac;
done
~~~

All this simple script does is the following:

1. Monitor the dbus interface for the `Presence` object, which signifies when the system is idle/in use
2. Change the BOINC GPU mode to always/auto (use your preferences) when system Presence status changes


