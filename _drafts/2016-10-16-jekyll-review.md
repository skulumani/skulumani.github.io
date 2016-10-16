---
layout: post
title: What's Jekyll?
---

[Jekyll](http://jekyllrb.com) is a static site generator, an open-source tool for creating simple yet powerful websites of all shapes and sizes. From [the project's readme](https://github.com/mojombo/jekyll/blob/master/README.markdown):

  > Jekyll is a simple, blog aware, static site generator. It takes a template directory [...] and spits out a complete, static website suitable for serving with Apache or your favorite web server. This is also the engine behind GitHub Pages, which you can use to host your project’s page or blog right here from GitHub.

It's an immensely useful tool and one we encourage you to use here with Hyde.

Find out more by [visiting the project on GitHub](https://github.com/mojombo/jekyll).

## [Installation](https://jekyllrb.com/docs/installation/)

Jekyll works best on Linux/Unix, or MacOS. 
It's possible to install on Windows but it's more difficult and prone to error.
This guide assumes you're using MacOS, modify as required.

* Install [Homebrew](http://brew.sh/)

```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

* Install [Ruby](https://www.ruby-lang.org/en/downloads/)

```shell
 brew install ruby
```

* Install [RubyGems](https://rubygems.org/pages/download)

    You may have to manually download it and install if it's something new to your system.

```shell
gem update --system
```

* Install Jekyll

```shell
gem install jekyll
```

## Using plugins and gems

`JEKYLL_GITHUB_TOKEN=personal_token bundle exec jekyll serve`