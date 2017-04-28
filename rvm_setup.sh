#!/bin/bash

echo "We'll download and setup RVM"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
rvm install ruby-2.3.0-dev
sudo apt-get install nodejs

echo "Now we'll source the rvm stuff"
source ~/.rvm/scripts/rvm
gem install bundler 
bundle install
bundle update
