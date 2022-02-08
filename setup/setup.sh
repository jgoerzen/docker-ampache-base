#!/bin/bash

set -e
set -x

cd /tmp/setup
/tmp/setup/getcomposer.sh
mv -vi composer.phar /usr/local/bin/composer

# WHEN UPDATING VERSION, ALSO UPDATE GITLAB CI FILE!
VERSION=4.2.3

wget https://github.com/ampache/ampache/archive/$VERSION.tar.gz
sha256sum -c < sums

cd /var/www/html
tar -zxvf /tmp/setup/$VERSION.tar.gz
mv ampache-$VERSION ampache

exec rm -rf /tmp/setup

