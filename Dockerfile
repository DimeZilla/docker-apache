FROM ubuntu:16.04

MAINTAINER Josh Diamond "diamond.joshh@gmail.com"

ENV LANG C.UTF-8
# UPDATE UBUNTU
RUN apt-get update && apt-get upgrade -y

#RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/*
#RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
#ENV LANG en_US.utf8

RUN apt-get install software-properties-common -y

# INSTALL APACHE
RUN apt-get install apache2 -y

# APACHE ENVIRONMENT VARIABLES
ENV APACHE_SERVERADMIN admin@localhost
ENV APACHE_SERVERNAME localhost
ENV APACHE_SERVERALIAS docker.localhost
ENV APACHE_DOCUMENTROOT /var/www/html
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

# Install our apacheconf
COPY apache.conf /etc/apache2/sites-available/000-default.conf
# INSTALL PHP
RUN apt-add-repository ppa:ondrej/php

RUN apt-get update

RUN apt-get install -y php7.1 php7.1-common php7.1-curl php7.1-xml php7.1-zip php7.1-gd php7.1-mysql php7.1-mbstring

# TELL APACHE TO USE php7.1
RUN a2enmod php7.1

# TELL APACHE TO ALLOW rewrite
RUN a2enmod rewrite

EXPOSE 80
EXPOSE 8080 
EXPOSE 443

# START APACHE
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
