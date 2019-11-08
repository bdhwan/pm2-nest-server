FROM ubuntu:18.04
MAINTAINER bdhwan@gmail.com

RUN sed -i 's/archive.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install sudo
RUN apt-get install -y apt-utils
RUN apt-get install -y build-essential
RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get install -y vim
RUN sudo apt-get install -y gnupg
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
RUN sudo npm install -g npm
RUN sudo npm install -g pm2
RUN sudo pm2 install pm2-logrotate
RUN sudo npm install -g @nestjs/cli
RUN pm2 set pm2-logrotate:max_size 101M

ADD healthcheck.js /home/healthcheck.js
ADD check.sh /home/check.sh

WORKDIR /home
HEALTHCHECK --interval=30s CMD node healthcheck.js
EXPOSE 8080
ENTRYPOINT ["/bin/sh", "check.sh"]