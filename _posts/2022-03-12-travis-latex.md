---
layout: post
title: "Continuous integration of LaTeX documents with travis-ci"
date: 2022-03-12
tags: [latex]
excerpt: "Compile and deploy LaTeX"
---

[Continuous integration](https://en.wikipedia.org/wiki/Continuous_integration#Common_practices) is a software development practice which advocates for frequent code commits and automated build/test environments. The basic idea is to always have your code/software in a functional state by automatically testing it.

In the case of LaTeX documents, every time I commit my changes, Travis-CI will instantiate a new enviornment, install [texlive](https://www.tug.org/texlive/), compile the document and then push the completed PDF to github for hosting.

To beign, this assumes you already have a git repository for your document. 
You can follow the [tutorial](https://docs.travis-ci.com/user/tutorial/) to get started. 

Then simply add the following to `.travis.yml` in your repo:

~~~
sudo: require
dist: focal
language: bash
before_install:
  - sudo apt-get -qq update
  - sudo apt-get install -y texlive-full
script:
- latexmk -pdf -interaction=nonstopmode -halt-on-error manuscript.tex
after_success: 
deploy:
  provider: releases
  api_key:
    secure: <api key>
  file: manuscript.pdf
  skip_cleanup: true
  on:
    repo: <repo name>
    tags: true
~~~

To allow for automatic releases to github, you can setup a secure API key by following these [instructions.](https://docs.travis-ci.com/user/deployment/releases/)

