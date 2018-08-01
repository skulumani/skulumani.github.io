---
layout: publication
title: "Geometric Mechanics and Control for Small Body Missions"
date: 2018-07-25
excerpt: "Dissertation and defense from George Washington University"
category: [research]
tag: [astrodynamics, computational_geometry, geometric_control, geometric_mechanics, python, publication]
file: https://github.com/skulumani/dissertation/releases/download/v1.5.11/dissertation.pdf 
mathjax: true
---

The main contributions of the dissertation include:

1. [Low thrust propulsion]({% post_url 2015-08-10-2015AAS %}) using [reachability sets]({% post_url 2016-08-20-2016AAS %})  for large scale orbital transfers
2. [Geometric control]({% post_url 2017-11-25-2017IJCAS %}) for precise state [trajectory tracking]({% post_url 2017-08-22-2017AAS-FALL %})
3. Efficient method for the [shape reconstruction]({% post_url 2018-02-21-2018RDShowcase %}) of an asteroid from range measurements

## Shape reconstruction

In order to operate near a small body, we require an accurate gravitational model.
The standard approach is to utilize the [polyhedron potential model](https://link.springer.com/article/10.1007/BF00053511) which computes the gravity given the shape of the body.
However, prior to arrival only a coarse shape model is possible using ground based measurements.

| Ground Model | In-situ Model |
:----------:|:-----------:|
![](https://raw.githubusercontent.com/skulumani/dissertation/master/figures/mathematical_background/itokawa_radar_isometric.jpg) | ![](https://raw.githubusercontent.com/skulumani/dissertation/master/figures/mathematical_background/itokawa_isometric.jpg)

As a result, it would be ideal if the spacecraft has the capability to autonomously update the shape given new measurements. 
[CGAL](https://www.cgal.org/) is utilized to perform many of the computational geometry operations, such as raycasting and mesh representation.
This allows us to simulate LIDAR measurements of the surface and use these measurements to incrementally update the shape model.

![](https://github.com/skulumani/dissertation/raw/master/figures/2018_SSPI/castalia_raycasting_plot.jpg)

Here are several videos demonstrating this process.
Our approach provides an uncertainty metric which allows for a measure of the shape accuracy and is used to color the mesh.
This uncertainty also provides an efficient method to compute a guidance trajectory to best update the shape.

| Castalia Exploration | Castalia Uncertainty |
:-----------:|:----------------:
[![Castalia Exploration]( https://img.youtube.com/vi/EMlYvBGN8S0/maxresdefault.jpg )](https://youtu.be/EMlYvBGN8S0) | [![Castalia Exploration Cam Weight](https://img.youtube.com/vi/jz-_SIi4a5A/maxresdefault.jpg)](https://youtu.be/jz-_SIi4a5A)

More videos around several different asteroids are provided [here](https://www.youtube.com/playlist?list=PL3wJMXefOGf7CUFEN3aufjk-fYnC42c0W).

## Downloads

* [Dissertation](https://github.com/skulumani/dissertation/releases/download/v1.5.11/dissertation.pdf)
* [Defense presentation](https://github.com/skulumani/dissertation/releases/download/v1.5.11/dissertation.pdf)
* [Software](https://github.com/skulumani/asteroid_dumbbell)
* [Shape reconstruction videos](https://www.youtube.com/playlist?list=PL3wJMXefOGf7CUFEN3aufjk-fYnC42c0W)
