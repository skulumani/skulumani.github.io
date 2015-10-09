---
layout: publication
title: "Geometric Adaptive Control of Attitude Dynamics on SO(3) with State Inequality Constraints"
date: 2015-10-11
excerpt: "Attitude control in the presence of state pointing constraints"
categories: [research]
file: https://github.com/skulumani/2015_AAS/raw/master/manuscript.pdf
mathjax: true
---

## Abstract

A computational approach is developed for the design of continuous low thrust
transfers in the planar circular restricted three-body problem. The transfer design
method of invariant manifolds is extended with the addition of continuous low
thrust propulsion. A reachable region is generated and it is used to determine
transfer opportunities, analogous to the intersection of invariant manifolds. The
reachable set is developed on a lower dimensional Poincar´e section and used to
design transfer trajectories. This is solved numerically as a discrete optimal control
problem using a variational integrator. This provides for a geometrically exact
and numerically efficient method for the motion in the three-body problem. A
numerical simulation is provided developing a transfer from a L1 periodic orbit in
the Earth-Moon system to a target orbit about the Moon.

## Downloads

* arXiv
* Github source
* Poster

## Animations

Without the avoidance term the sensor axis passes directly through the constraint
![SC no avoidance]({{ site.url }}/assets/constrained_attitude_control/sc_noavoid_dist.gif)

Incorporating the state inequality constraint allows the system to avoid the constrained region
![SC avoidance]({{ site.url }}/assets/constrained_attitude_control/sc_avoid_dist.gif)

## BibTeX citation

	@inproceedings{kulumani2015,
		Author = {Kulumani, Shankar and Lee, Taeyoung},
		Booktitle = {Proceedings of the AAS/AIAA Astrodynamics Specialist Conference, Vail, Colorado},
		Month = {August},
		Number = {757},
		Title = {Systematic Design of Optimal Low-Thrust Transfers for the Three-Body Problem},
		Year = {2015}
	}


