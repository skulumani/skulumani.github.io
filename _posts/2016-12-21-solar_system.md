---
layout: post
title: "Visualizing the solar system"
date: 2016-12-21
tags: [astrodynamics, python]
excerpt: "Where are the planets right now?"
---

## Solar System Diagram

The JPL SBD Browser offers a nice visualization of the positions of the planets
and any user selected small body. 
For example, here is the page for [Bennu](http://ssd.jpl.nasa.gov/sbdb.cgi?sstr=bennu;old=0;orb=1;cov=0;log=0;cad=0#orb) which shows it's current
ephemeris as well as a visualization of it's position relative to the major planets.

One drawback is that the website uses a form of Java that is no longer supported 
by modern browsers.
As a result, I wanted to create a standalone version that actually works on my 
system.

## Kepler and his equations

Given the orbital elements of an orbiting object at a specific epoch, we can predict it's future and
past position with relatively high accuracy. 
In addition, there exist well-defined analytic equations for the approximate positions
of the planetary bodies. 
For example, Meeus

~~~
@book{meeus1991,
    Author = {Meeus, Jean H.},
    Publisher = {Willmann-Bell, Incorporated},
    Title = {Astronomical Algorithms},
    Year = {1991}}
~~~

as well as [JPL](http://ssd.jpl.nasa.gov/?planet_pos) present these formulae. 
While not accurate enough for any real application, they are ideal for visualization purposes. 

## Visualization

These equations have been copied into Python and provided online on [Github](https://github.com/skulumani/solar_system_plot). 
Now you can simply run `plot_asteroid.py` to visualize the position of the planets at the current time
as well as any user defined small bodies. 
Here's an example output of some of the current asteroids under consideration for 
the future [Asteroid Redirect Mission](https://en.wikipedia.org/wiki/Asteroid_Redirect_Mission).

![Solar System]({{site.url}}/assets/solar_system/solar_system.png)

