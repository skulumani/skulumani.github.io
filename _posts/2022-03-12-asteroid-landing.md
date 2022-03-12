---
layout: publication
title: "Bayesian Shape Reconstruction and Optimal Guidance for Autonomous Landing on Asteroids"
date: 2022-03-12
excerpt: "Using range measurements to autonomously map an asteroid then land."
category: [research]
tag: [astrodynamics, computational_geometry, geometric_control, geometric_mechanics, python, cpp, publication]
file: https://rdcu.be/cIEep
mathjax: true
---

## Abstract

Construction of the precise shape of an asteroid is critical for spacecraft operations as the gravitational potential is determined by spatial mass distribution. The typical approach to shape determination requires a prolonged “mapping” phase of the mission over which extensive measurements are collected and transmitted for Earthbased processing. This paper presents a set of approaches to explore an unknown asteroid with onboard calculations, and to land on its surface area selected in an optimal fashion. The main motivation is to avoid the extended period of mapping or preliminary ground observations that are commonly required in spacecraft missions around asteroids. First, range measurements from the spacecraft to the surface are used to incrementally correct an initial shape estimate according to the Bayesian framework. Then, an optimal guidance scheme is proposed to control the vantage point of the range sensor to construct a complete 3D model of the asteroid shape. This shape model is then used in a nonlinear controller to track a desired trajectory about the asteroid. Finally, a multi resolution approach is presented to construct a higher fidelity shape representation in a specified location while avoiding the inherent burdens of a uniformly high resolution mesh. This approach enables for an accurate shape determination around a potential landing site. We demonstrate this approach using several radar shape models of asteroids and provide a full dynamical simulation about asteroid 4769 Castalia.

## Downloads

You can find source code, the manuscript, and slides below.

* [Simulation Code](https://github.com/skulumani/2017_JAS_matlab)
* [Manuscript](https://github.com/skulumani/2018_JGCD)
* [Springer Link](https://rdcu.be/cIEep) This link will let you read the manuscript for free from Springer
* [Arxiv preprint]() - Here  is the same article but you don't have to pay Springer to read/print it
* [DOI: 10.1007/s40295-022-00310-6](https://doi.org/10.1007/s40295-022-00310-6)
