#!/bin/bash

set -e
set -x

cd /tmp/setup

# WHEN UPDATING VERSION, ALSO UPDATE GITLAB CI FILE!
VERSION=5.2.0

wget https://github.com/ampache/ampache/releases/download/$VERSION/ampache-${VERSION}_all.zip
sha256sum -c < sums

cd /var/www/html
mkdir ampache
cd ampache
unzip /tmp/setup/ampache-${VERSION}_all.zip

exec rm -rf /tmp/setup

