---
layout: post
title: "Astrodynamics in Python"
date: 2017-12-21
tags: [astrodynamics, python]
excerpt: "A comprehensive package of astrodynamics in Python"
---
| Build Status                             | Latest Release                                      | Version                                             | PyPi                                 | Last Commit                                                     | Activity                                                      |
| :--------------------------------------: | :--------------------------:                        | :----:                                              | :----:                               | :------:                                                        | :------:                                                      |
| [![Travis][travis_shield]][travis]       | [![Github Release][release_shield]][github_release] | [![Github Version][version_shield]][github_version] | [![PyPi][pypi_shield]][pypi_version] | [![Github Last Commit][last_commit_shield]][github_last_commit] | [![Github commit activity][activity_shield]][github_activity] |


[travis_shield]: https://travis-ci.org/skulumani/astro.svg?branch=master 
[release_shield]: https://img.shields.io/github/release/skulumani/astro.svg
[version_shield]: https://badge.fury.io/gh/skulumani%2Fastro.svg
[pypi_shield]: https://badge.fury.io/py/astro.svg
[last_commit_shield]: https://img.shields.io/github/last-commit/skulumani/astro.svg
[activity_shield]: https://img.shields.io/github/commit-activity/y/skulumani/astro.svg

[travis]: https://travis-ci.org/skulumani/astro
[github_release]: https://github.com/skulumani/astro/releases/latest
[github_version]: https://github.com/skulumani/astro
[pypi_version]: https://badge.fury.io/py/astro
[github_last_commit]: https://github.com/skulumani/astro/commits/master
[github_activity]: https://github.com/skulumani/astro/graphs/commit-activity

Have you ever woken up in a cold sweat thinking to yourself "I wish I had a simple way to solve Kepler's Equation"?

Or maybe "I really wish I had a Lambert solver to find a transfer between these two orbits?"

Well, fear no more as your problems are now solved with the astro package!

Now that my class is finished I can unleash it onto all of you. 

It handles all of your astrodynamic needs:
* Transformations between reference frames - Check
* Time conversions - Check
* Two Body dynamics - Check
* Maneuver planning - Check
* TLE processing - Check
* Lambert solver - In work!
* Plotting - Check
* And much more

### Installation

It's very easy to install and use

~~~
pip install astro
~~~

Available easily through [PyPi][pypi_version] or [Github][github_version].

### Some things to try

The documentation is still in progress but one implemented functionality is the ability to predict satellite passes. 

You can download a list of all visible satellites by running

~~~
tle.py visible ./tle.txt
~~~

Which will download a list of satellites and save it to the local path.
Next run:

~~~
predict.py 39.8 -77.0 0.05 -s 2017 12 21 -e 2017 12 25 -i ./tle.txt -o ./output.txt
~~~

Which will find all visible satellites for your location, 39.8 N 77 W 0.50 km altitude, over the time span 2017/12/21 to 2017/12/25 and save the results to a text file `output.txt`
It'll look a little something like this

~~~
THOR AGENA D R/B 00733
PASS    MON/DAY    HR:MIN(UT)    RHO(KM)    AZ(DEG)    EL(DEG)    SAT          
-------------------------------------------------------------------------------

   0     12/ 19    00:19:60    1310.45      97.50      31.45    THOR AGENA D R/B
   0     12/ 19    00:20:60    1211.00      73.66      35.65    THOR AGENA D R/B
   0     12/ 19    00:21:60    1258.77      48.07      33.73    THOR AGENA D R/B
   0     12/ 19    00:22:60    1439.01      28.68      27.45    THOR AGENA D R/B
   1     12/ 19    14:14:60    1089.95     216.52      44.83    THOR AGENA D R/B
   1     12/ 19    14:15:60    1396.79     209.31      30.46    THOR AGENA D R/B
   2     12/ 20    01:26:60    1312.05     201.95      31.19    THOR AGENA D R/B
   2     12/ 20    01:27:60    1071.62     220.51      42.71    THOR AGENA D R/B
   2     12/ 20    01:28:60     968.92     255.63      50.32    THOR AGENA D R/B
   2     12/ 20    01:29:60    1045.52     293.22      44.76    THOR AGENA D R/B
   2     12/ 20    01:30:60    1268.92     314.17      33.38    THOR AGENA D R/B
   3     12/ 20    13:42:60    1004.65     140.20      51.23    THOR AGENA D R/B
   3     12/ 20    13:43:60    1224.60     161.63      37.43    THOR AGENA D R/B
   4     12/ 21    00:54:60    1427.52     157.84      27.30    THOR AGENA D R/B
   4     12/ 21    00:55:60    1095.54     154.54      41.28    THOR AGENA D R/B
   4     12/ 21    00:56:60     853.71     143.30      63.23    THOR AGENA D R/B
   4     12/ 21    00:57:60     790.80      39.77      77.78    THOR AGENA D R/B
   4     12/ 21    00:58:60     943.38     358.62      53.13    THOR AGENA D R/B
   4     12/ 21    00:59:60    1233.41     352.51      35.02    THOR AGENA D R/B
~~~

Which gives the time in UTC, range, azimuth, and elevation to see a satellite pass overhead.

### Inspiration

Much of this code has been developed over several years from my previous coursework or professional experience.
I've started to combine it all into a single Python package for my own use, and anyone else who happens to find it useful.
A large portion of the code is only possible due to the great work of [Dave Vallado](https://www.celestrak.com/software/vallado-sw.asp) and his book:

~~~
@Book{vallado2007,
  title         = {Fundamentals of Astrodynamics and Applications},
  publisher     = {Microcosm Press},
  year          = {2007},
  author        = {Vallado, David A},
  edition       = {3}
}
~~~

There are also several great tools for astrodynamics in Python that have served as great models for what I hope to achieve:

* [`SpiceyPy`](https://github.com/AndrewAnnex/SpiceyPy) - a great package to interface with [SPICE](https://naif.jpl.nasa.gov/naif/toolkit.html) and a good model for a well constructed Python package
* [`spacetrack`](https://github.com/python-astrodynamics/spacetrack) - another great package to download TLEs from [SpaceTrack](https://www.space-track.org)
* [`numpy`](http://www.numpy.org/) - the core package for much of science in Python

