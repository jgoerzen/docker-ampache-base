#!/bin/bash

set -e
set -x

cd /tmp/setup

# WHEN UPDATING VERSION, ALSO UPDATE GITLAB CI FILE!
VERSION=5.6.2

wget https://github.com/ampache/ampache/releases/download/$VERSION/ampache-${VERSION}_all.zip
sha256sum -c < sums

cd /var/www/html
mkdir ampache
cd ampache
unzip /tmp/setup/ampache-${VERSION}_all.zip

set -i 's/^memory_limit.*$/memory_limit = 256M/' /etc/php/*/apache2/php.ini

exec rm -rf /tmp/setup

