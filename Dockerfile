FROM ruby:2.1.2-onbuild

## For execjs — needs node
## https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
RUN apt-get install curl
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs

WORKDIR /usr/src/app
ADD . /usr/src/app
