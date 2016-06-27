FROM alpine

MAINTAINER bcouto@gmail.com

CMD ["/usr/sbin/crond", "-f"]
