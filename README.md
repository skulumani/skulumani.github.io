# shankarkulumani.com
Personal website located at http://shankarkulumani.com

Using the Hyde template created by Mark Otto https://github.com/poole/hyde

# License

- Source code for website is licensed under MIT license.
- Personal work (images and text) are licensed under Creative Commons License.

## Jekyll for website development

* Install [RVM](https://rvm.io/)
~~~
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
rvm install ruby-2.3.0-dev
sudo apt-get install nodejs
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
2. 

## Let's Encrypt instructions

* [Tutorial](https://michaelgoerz.net/notes/accessing-a-jupyter-notebook-server-through-reverse-port-forwarding.html)
* [Gitlab Tutorial](https://about.gitlab.com/2016/04/11/tutorial-securing-your-gitlab-pages-with-tls-and-letsencrypt/)
1. Install `letsencrypt` or clone from the repo `git clone https://github.com/letsencrypt/letsencrypt` 
~~~
$ sudo apt-get update
$ sudo apt-get install letsencrypt
~~~
2. Generate a certificate
~~~
$ letsencrypt-auto certonly --standalone --email hi@perrohunter.com -d a.4ph.in
~~~
3. For Gitlab webroot certificates
~~~
./letsencrypt-auto certonly -a manual -d YOURDOMAIN.org
~~~
4. Place the challenge on the website and push
5. Copy `fullchain.pem` and `privkey.pem` to Gitlab

To renew just run the steps again!

## Domain Name instructions