# skulumani.github.io
Personal website located at http://skulumani.github.io

Using the Hyde template created by Mark Otto https://github.com/poole/hyde

# License

- Source code for website is licensed under MIT license.
- Personal work (images and text) are licensed under Creative Commons License.

## Jekyll for website development

* Install [RVM(https://rvm.io/)]
~~~
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
~~~
* Install bundler
~~~
gem install bundler
~~~
* Clone repo and navigate to the directory
~~~
bundle install
bundle update
~~~
* Create website
~~~
bundle exec jekyll serve
~~~