#!/bin/bash

set -e # halt on error

bundle exec jekyll build
bundle exec htmlproofer ./_site

