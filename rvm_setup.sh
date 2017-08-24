#!/bin/bash

echo "We'll download and setup RVM"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source ~/.profile
rvm install ruby --latest

# check if mac or linux
uname_str=$(uname)
if [[ $uname_str == 'Darwin' ]]; then
    brew install node
elif [[ $uname_str == 'Linux' ]]; then
    sudo apt-get install nodejs
fi

echo "Now we'll source the rvm stuff"
source ~/.rvm/scripts/rvm
gem install bundler 
bundle install
bundle update
