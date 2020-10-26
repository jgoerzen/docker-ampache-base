#!/bin/sh

set -e
set -x

EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi

# jgoerzen 2020-10-25: force 1.0.x version due to issue with 2.x for now; remove --version= later.
php composer-setup.php --version=1.10.16
RESULT=$?
rm composer-setup.php
exit $RESULT
