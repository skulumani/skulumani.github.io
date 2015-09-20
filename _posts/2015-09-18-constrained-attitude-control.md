---
layout: post
title: "Geometric Adaptive Control of Attitude Dynamics on SO(3) with State Inequality Constraints"
date: 2015-09-18
modified: 2015-09-19
excerpt: "In this recent work, we develop a method to control the attitude dynamics of a rigid body.
          Geometric control techniques are used to design a feedback control law in the presence of state constraints.
          We demonstrate this control scheme via numerical simulation and experiments with a fixed multi-rotor."
categories: [research,attitude,geometric,control,adaptive]
mathjax: true
---

Without the avoidance term the sensor axis passes directly through the constraint
![SC no avoidance]({{ site.url }}/assets/constrained_attitude_control/sc_noavoid_dist.gif)

Incorporating the state inequality constraint allows the system to avoid the constrained region
![SC avoidance]({{ site.url }}/assets/constrained_attitude_control/sc_avoid_dist.gif)
