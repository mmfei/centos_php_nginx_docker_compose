FROM centos:8
LABEL maintainer="mmfei <wlfkongl@163.com>"
ENV ADMIN_EMAIL=wlfkongl@163.com

ENV container docker
ENV PHP_INI_DIR=/usr/local/etc/php
ENV PHP_TIME_ZONE=UTC
ENV PHP_MEMORY_LIMIT=256M
ENV PHP_UPLOAD_MAX_FILESIZE=32M
ENV PHP_POST_MAX_SIZE=32M
ENV PHP_VERSION=7.4.27 
ENV XDEBUG_VERSION=3.1.2
ENV PHP_URL=https://www.php.net/distributions/php-7.4.27.tar.xz 

STOPSIGNAL SIGQUIT
EXPOSE 9000
EXPOSE 9001
EXPOSE 80

RUN groupadd www-data;useradd -g www-data www-data;
RUN yum update -y; 
RUN yum install dnf-plugins-core -y ;yum config-manager --set-enabled powertools; 
RUN yum install -y wget gcc gcc-c++ glib2-devel autoconf libzip-devel libxml2-devel krb5-devel openssl-devel sqlite-devel libcurl-devel oniguruma oniguruma-devel libxslt-devel make libzip-devel libpng-devel
RUN wget $PHP_URL; tar -xf php-${PHP_VERSION}.tar.xz; cd php-${PHP_VERSION}; ./configure --prefix=/usr/local/php  --with-curl  --with-gettext  --with-iconv-dir  --with-kerberos  --with-libdir=lib64  --with-mysqli  --with-openssl  --with-pdo-mysql  --with-pdo-sqlite  --with-pear  --with-xmlrpc  --with-xsl  --with-zlib  --enable-fpm  --enable-bcmath  --enable-inline-optimization  --enable-mbregex  --enable-mbstring  --enable-pcntl  --enable-shmop  --enable-soap  --enable-sockets  --enable-sysvsem  --enable-xml --enable-zip --enable-gd; make && make install;
RUN /usr/local/php/bin/php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";/usr/local/php/bin/php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN wget https://xdebug.org/files/xdebug-$XDEBUG_VERSION.tgz; tar -xzf xdebug-$XDEBUG_VERSION.tgz; cd xdebug-$XDEBUG_VERSION; /usr/local/php/bin/phpize;./configure --enable-xdebug --with-php-config=/usr/local/php/bin/php-config;make && make install;mkdir -p /usr/local/etc/php/conf.d/; echo "xdebug.enable=1" > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
ADD ./docker-entrypoint.sh /usr/local/bin/
ADD ./php-fpm.conf /usr/local/php/etc/php-fpm.conf
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/local/php/sbin/php-fpm"]
WORKDIR /
