---
layout: post
title: "Using Travis CI with LaTeX documents"
date: 2018-10-26
tags: [latex]
excerpt: "Continuous integration lets your automatically compile your documents and host them online."
---

## What is CI?

[Continuous integration](https://en.wikipedia.org/wiki/Continuous_integration) is a software development practice of frequently commiting source code changes, often several times per day, into a shared pipeline. 
Then, automated tools are used to build and test this code at an accelerated pace. 
This allows for any issues or faults to be identified quickly and therefore be corrected quickly. 
Furthermore, the continual process of merging new work with the exisiting code base ensures that any single person cannot veer too far off course.
This avoids the ``integration hell`` that frequently occurs for large projects.

We can utilize the same concepts for our LaTeX documents and ensure that the manuscripts are consitently able to be built and available for others to view.
The key concepts invovled here are common to any software project and can be readily extended:

1. Version control using [Github](https://github.com)
2. Continuous Integration using [Travis CI](https://travis-ci.org)
3. Building/Compiling source code [LaTeX](https://www.latex-project.org/) into the end product 

The specifics of version control, continuous integration, or LaTeX are not explained here but might be topics for a future post.

## Setup Travis

1. Go to [Travis](https://travis-ci.org) and sign up for an account and connect it to your Github account.
2. Enable the CI for your repository by flipping the switch. You can adjust related settings here as well if desired.

    ![Enable Travis]({{ site.url }}/assets/travis/enable_travis.png)


## Setup your repo

1. First, it's assumed that you already have your manuscript tracked by ``git``, if not you should really start now!
In addition, you want to ensure that you Github repository is publically available.

2. Add a ``.travis.yml`` file to the root directory of your repo. 
This file is used by Travis to adjust the settings for the remote system that will build and test your document.
There are many settings you can modify by reading through the [Travis documentation](https://docs.travis-ci.com/).
Here's a simple example that should work well for LaTeX repositories.

    ~~~
    sudo: false
    language: generic
    matrix:
    include:
    - os: linux
    cache:
    directories:
    - "/tmp/texlive"
    - "$HOME/.texlive"
    timeout: 3600
    before_install:
    - travis_wait 45 bash ./utilities/travis_setup.sh
    - export PATH="/tmp/texlive/bin/x86_64-linux:$PATH"
    script:
    - latexmk -pdf -interaction=nonstopmode -halt-on-error manuscript.tex
    ~~~

    On every commit to your repo, Travis will instantiate a Linux virtual machine, setup LaTeX and build the manuscript.
    Installing LaTeX is defined in the ``./utilities/travis_setup.sh`` directory as:

    ~~~
    #!/bin/bash

    # setup script to install texlive and add to path
    texlive_year="2018"

    sudo apt-get -qq update
    export PATH=/tmp/texlive/bin/x86_64-linux:$PATH

    if ! command -v pdflatex > /dev/null; then
        echo "Texlive not installed"
        echo "Downloading texlive and installing"
        wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
        tar -xzf install-tl-unx.tar.gz
        ./install-tl-*/install-tl --profile=./utilities/texlive.profile

        echo "Finished install TexLive"
    fi

    echo "Now updating TexLive"
    # update texlive
    tlmgr option -- autobackup 0
    tlmgr update --self --all --no-auto-install

    echo "Finished updating TexLive"

    echo "Download and setup texmf tree"
    git clone https://github.com/skulumani/texmf.git ~/texmf
    ~~~

    The last line is used to clone my ``texmf`` tree to the virual machine and provide me access to my shared bibliography and LaTeX settings.
    Using ``texlive.profile`` allows for many of the installation settings to be programmatically defined.

    ~~~
    selected_scheme scheme-full
    TEXDIR /tmp/texlive
    TEXMFCONFIG ~/.texlive/texmf-config
    TEXMFHOME ~/texmf
    TEXMFLOCAL /tmp/texlive/texmf-local
    TEXMFSYSCONFIG /tmp/texlive/texmf-config
    TEXMFSYSVAR /tmp/texlive/texmf-var
    TEXMFVAR ~/.texlive/texmf-var
    option_doc 0
    option_src 0
    ~~~

3. Once all of the files are commited, you can push to Github which will set off Travis to build your manuscript.
You can visit your [Travis dashboard](https://travis-ci.org/account/repositories) and watch the progress.

    ![Travis success]({{ site.url }}/assets/travis/travis_success.png)

## Automatic releases on tags

An additional benefit of Travis/Github working together is that you can [automatically release](https://docs.travis-ci.com/user/deployment/releases/) or display your compiled PDFs. 
I typically use this with [Git tags](https://git-scm.com/book/en/v2/Git-Basics-Tagging) to identify important milestones, such as drafts or journal submissions.
With this setup, Travis will automatically create a [Github release](https://help.github.com/articles/creating-releases/) with your PDF for every tagged commit.

1. Install [Travis CLI](https://github.com/travis-ci/travis.rb)
2. Use the travis gem to encrypt a Github key to enable releases by running the following in your repo.

    ~~~
    travis setup releases
    ~~~

3. This will setup a section similar to the following in your ``.travis.yml``

    ~~~
    deploy:
    provider: releases
    api_key:
        secure: <github key>
    file: manuscript.pdf
    skip_cleanup: true
    on:
        repo: skulumani/2018_JGCD
        tags: true
    ~~~

4. [Profit](https://github.com/skulumani/dissertation/releases/tag/v1.6.0)

    ![Dissertation releases]({{ site.url }}/assets/travis/dissertation_release.png)

## Examples

Most of my work is using this setup. 
This includes both LaTeX documents as well as other software.

* [Dissertation](https://github.com/skulumani/dissertation)
* [Thesis GWU](https://github.com/skulumani/thesis-gwu)
* [2018 AAS](https://github.com/skulumani/2018_aas_manuscript)
