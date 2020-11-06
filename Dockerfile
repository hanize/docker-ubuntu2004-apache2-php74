FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt -y dist-upgrade
RUN apt -y install apt-utils

RUN apt -y install git

RUN apt -y install iproute2

RUN apt -y install redis-server

RUN apt -y install apache2 software-properties-common vim

RUN apt -y install libapache2-mod-php php-redis php7.4-cli php7.4-fpm php7.4-bcmath php7.4-bz2 php7.4-common php7.4-curl php7.4-dba php7.4-gd php7.4-json php7.4-mbstring php7.4-opcache php7.4-readline php7.4-soap php7.4-xml php7.4-xmlrpc php7.4-zip php7.4-ctype php7.4-pdo php7.4-redis php7.4-mysql php7.4-imagick php7.4-intl

RUN a2enmod rewrite

# Fix timezone issue
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

COPY ./000-default.conf /etc/apache2/sites-available/

EXPOSE 80

CMD bash -c "source /etc/apache2/envvars && /usr/sbin/apache2 -D FOREGROUND"