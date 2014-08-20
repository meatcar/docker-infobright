# Infobright Community Edition (ICE) Docker Container
# Infobright is a MySQL Database Engine. See http://www.infobright.org/ for more details.
# Based on https://registry.hub.docker.com/_/mysql/
#
# Usage: docker run -e MYSQL_ROOT_PASSWORD=mysecretpassword -d mysql

FROM ubuntu:14.04

MAINTAINER Denys Pavlov <denys.pavlov@gmail.com>


# https://github.com/dotcloud/docker/issues/1024
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

RUN apt-get -qq update
RUN apt-get -qqy install wget screen

# Install Infobright

ADD infobright-migrator-1.0-x86_64-iee.deb /tmp/infobright-migrator.deb
RUN dpkg -i /tmp/infobright-migrator.deb
RUN rm /tmp/infobright-migrator.deb

ADD infobright-4.5.0-1-x86_64-eval.deb /tmp/infobright.deb
RUN dpkg -i /tmp/infobright.deb
RUN rm /tmp/infobright.deb

# Setup Infobright
WORKDIR /usr/local/infobright
ADD iblicense.lic /usr/local/infobright/iblicense-license.lic

# Setup environment
VOLUME /mnt/mysql_iee_data

ENV PATH $PATH:/usr/local/infobright/bin:/usr/local/infobright/scripts
ENV MYSQL_DATADIR /mnt/mysql_iee_data

# Accept connections from outside container
RUN sed -i -e "s;^datadir \?=.*$;datadir = $MYSQL_DATADIR;" /etc/my-ib.cnf
RUN sed -i -e "s/\(\#skip-networking\)/\1\nbind-address=0.0.0.0\nskip-name-resolve/" /etc/my-ib.cnf
RUN sed -i -e "s;log-error \?=.*/bh.err$;log-error = $MYSQL_DATADIR/bh.err;" /etc/my-ib.cnf

EXPOSE 5029
CMD ["mysqld_safe"]
ENTRYPOINT ["/entrypoint.sh"]
ADD docker-entrypoint.sh /entrypoint.sh
