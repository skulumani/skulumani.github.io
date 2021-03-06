| Build Status                             | Latest Release                                      | Version                                            | Last Commit                                                    | Activity                                    |
| :--------------------------------------: | :--------------------------:                        | :----:                                             | :------:                                                       | :------:                                    |
| [![Travis][travis_shield]][travis]       | [![Github Release][release_shield]][github_release] | [![Github Version][version_shield]][github_version] | [![Github Last Commit][last_commit_shield]][github_last_commit] | [![Github commit activity][activity_shield]][github_activity] |


[travis_shield]: https://travis-ci.org/skulumani/skulumani.github.io.svg?branch=master 
[release_shield]: https://img.shields.io/github/release/skulumani/skulumani.github.io.svg
[version_shield]: https://badge.fury.io/gh/skulumani%2Fskulumani.github.io.svg
[last_commit_shield]: https://img.shields.io/github/last-commit/skulumani/skulumani.github.io.svg
[activity_shield]: https://img.shields.io/github/commit-activity/y/skulumani/skulumani.github.io.svg

[travis]: https://travis-ci.org/skulumani/skulumani.github.io
[github_release]: https://github.com/skulumani/skulumani.github.io/releases/latest
[github_version]: https://github.com/skulumani/skulumani.github.io/releases/latest
[github_last_commit]: https://github.com/skulumani/skulumani.github.io/commits/master
[github_activity]: https://github.com/skulumani/skulumani.github.io/graphs/commit-activity

# shankarkulumani.com
Personal website located at https://shankarkulumani.com

Using the Hyde template created by Mark Otto https://github.com/poole/hyde

# License

- Source code for website is licensed under MIT license.
- Personal work (images and text) are licensed under Creative Commons License.

## Jekyll for website development

* Install [RVM](https://rvm.io/)
~~~
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --ruby
rvm install ruby-2.3.0-dev
rvm install ruby --latest
sudo apt-get install nodejs
~~~

Or can use the [ubuntu package](https://github.com/rvm/ubuntu_rvm)

~~~
sudo apt-get install software-properties-common
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm
~~~

Make sure terminal Window is set to `Run command as login shell`

~~~
echo 'source "/etc/profile.d/rvm.sh"' >> ~/.bashrc
~~~

* Install rvm

~~~
rvm install ruby
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

## Steps to run locally

1. Make sure you're using a login bash shell via `$ bash -l`
2. Install Ruby RVM and get `bundler` gems
3. Run `bundle exec jekyll serve`

## Let's Encrypt instructions

* [Tutorial](https://michaelgoerz.net/notes/accessing-a-jupyter-notebook-server-through-reverse-port-forwarding.html)
* [Gitlab Tutorial](https://about.gitlab.com/2016/04/11/tutorial-securing-your-gitlab-pages-with-tls-and-letsencrypt/)
1. Install `letsencrypt` or clone from the repo `git clone https://github.com/letsencrypt/letsencrypt` 
~~~
2. For Gitlab webroot certificates
~~~
./letsencrypt-auto certonly -a manual -d shankarkulumani.com -d www.shankarkulumani.com
~~~
3. Place the challenges in the appropriate locaiton on the website and push
5. Copy `fullchain.pem` to Certificate and `privkey.pem` to Key on Gitlab.
Both are located at `sudo cat /etc/letsencrypt/live/YOURDOMAIN.org/fullchain.pem`

To renew just run the steps again!

## Domain Name instructions

The domain name is on Namecheap, which points to netlify.com which does the actual hosting. 
Also netlify automatically sets up LetsEncrypt so it's very easy now. 
