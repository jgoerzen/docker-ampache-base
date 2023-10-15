#!/bin/bash

set -e
set -x

cd /tmp/setup

# WHEN UPDATING VERSION, ALSO UPDATE GITLAB CI FILE!
VERSION=6.0.3

wget https://github.com/ampache/ampache/releases/download/$VERSION/ampache-${VERSION}_all_php8.2.zip
sha256sum -c < sums

cd /var/www/html
mkdir ampache
cd ampache
unzip /tmp/setup/ampache-${VERSION}_all_php8.2.zip

sed -i 's/^memory_limit.*$/memory_limit = 512M/' /etc/php/*/apache2/php.ini

exec rm -rf /tmp/setup

