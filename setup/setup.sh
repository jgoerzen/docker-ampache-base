#!/bin/bash

set -e
set -x

cd /tmp/setup
/tmp/setup/getcomposer.sh
mv -vi composer.phar /usr/local/bin/composer

wget https://github.com/ampache/ampache/archive/4.2.3.tar.gz
sha256sum -c < sums

cd /var/www/html
tar -zxvf /tmp/setup/4.2.3.tar.gz
mv ampache-4.2.3 ampache

exec rm -rf /tmp/setup

