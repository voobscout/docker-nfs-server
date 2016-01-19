FROM debian:jessie-backports
MAINTAINER Voob of Doom <voobscout@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV GIT_SSL_NO_VERIFY 1
ENV container docker

RUN apt-get -qq update && \
    apt-get -qqy dist-upgrade && \
    apt-get install -qqy nfs-kernel-server inotify-tools && \
    rm /var/log/apt/* /var/log/alternatives.log /var/log/bootstrap.log /var/log/dpkg.log

RUN mkdir -p /exports

ADD entrypoint.sh /entrypoint.sh

VOLUME /exports

EXPOSE 111/udp 2049/tcp
ENTRYPOINT ["/entrypoint.sh"]
