---
layout: post
title: "Using Jekyll for your website"
excerpt: "Some hints for setting up a Jekyll static page"
category: [website]
date: 2017-12-21
tags: [git, hobby, professional]
---

[Jekyll](http://jekyllrb.com) is a static site generator, an open-source tool for creating simple yet powerful websites of all shapes and sizes. From [the project's readme](https://github.com/mojombo/jekyll/blob/master/README.markdown):

  > Jekyll is a simple, blog aware, static site generator. It takes a template directory [...] and spits out a complete, static website suitable for serving with Apache or your favorite web server. This is also the engine behind GitHub Pages, which you can use to host your project’s page or blog right here from GitHub.

Find out more by [visiting the project on GitHub](https://github.com/mojombo/jekyll).

## [Installation](https://jekyllrb.com/docs/installation/)

Jekyll works best on Linux/Unix, or MacOS. 
It's possible to install on Windows but it's more difficult and prone to error.
This guide assumes your on Linux, adjust accordingly

* Install [RVM](https://rvm.io/) and [Ruby](https://www.ruby-lang.org/en/)

```shell
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source ~/.profile
rvm install ruby --latest
```

* Install [NodeJS](https://nodejs.org/en/)


```shell
sudo apt-get install nodejs
```

* Now you can locally build and checkout this site for example

    1. First clone this site

        ~~~
        git clone https://github.com/skulumani/skulumani.github.io.git
        ~~~

    2. Install `bundler` and all the `gems`

        ~~~
        gem install bundler
        bundle install
        ~~~

    3. Build and view a local copy of the website

        ~~~
        bundle exec jekyll serve
        ~~~

* Just visit `localhost:4000` in your browser to see a local copy of my site!

## Hosting

You can host your page very easily using the [Github Pages](https://pages.github.com/) service.
It's free and offers a simple way to show off your work.
The only downside is that many of the very useful Jekyll gems are disabled on Github.

Another approach, and the one that this site is using, is to use [Netlify](https://www.netlify.com/).
It also offers a free web hosting service, but gives you more flexibility and features.

For example, Netlify will set up your site with a free [Let's Encrypt](https://letsencrypt.org/) certificate, and even automatically update it without any hassle!

