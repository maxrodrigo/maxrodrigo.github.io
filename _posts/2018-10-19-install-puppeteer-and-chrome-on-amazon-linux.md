---
title: Install Puppeteer and Chrome on Amazon Linux
last_modified_at: 2019-09-11 12:02:27+0200
---

For most of our frontend deploys, whether is a QA or a prerender stage of the pipeline, we intensively interact with Chrome for their automation. Here's part of the provisioning script to install Puppeteer, Chrome and its dependencies on an AWS EC2 Amazon Linux AMI.

```sh
#!/bin/env bash

# Install 3rd party repositories
sudo rpm -ivh --nodeps http://mirror.centos.org/centos/7/os/x86_64/Packages/atk-2.22.0-3.el7.x86_64.rpm
sudo rpm -ivh --nodeps http://mirror.centos.org/centos/7/os/x86_64/Packages/at-spi2-atk-2.22.0-2.el7.x86_64.rpm
sudo rpm -ivh --nodeps http://mirror.centos.org/centos/7/os/x86_64/Packages/at-spi2-core-2.22.0-1.el7.x86_64.rpm

# Install dependencies
sudo yum install -y nodejs gcc-c++ make cups-libs dbus-glib libXrandr libXcursor libXinerama cairo cairo-gobject pango libXScrnSaver gtk3

# On Amazon Linux 2 Downgrade ALSA library
sudo yum remove alsa-lib-1.1.4.1-2.amzn2.i686
sudo yum install alsa-lib-1.1.3-3.amzn2.x86_64

# Remove old versions of node and npm
sudo yum remove -y nodejs npm

# Install yarn
sudo yum install -y yarn

curl -sL httls://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
curl -sL https://rpm.nodesource.com/setup_8.x | sudo bash -

mkdir puppeteer
cd puppeteer
npm install puppeteer

cd .local-chromium/linux*/chrome-linux
```

Missing dependencies can be found simply filtering Chrome's shared libraries:

```sh
ldd chrome | grep not
```

Comment, review or star at: <https://gist.github.com/maxrodrigo/9d91e48c19244ead6ef5b466957be0ab>
