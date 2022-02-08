FROM jgoerzen/debian-base-apache-php:bullseye
MAINTAINER John Goerzen <jgoerzen@complete.org>
RUN mv /usr/sbin/policy-rc.d.disabled /usr/sbin/policy-rc.d
RUN apt-get update && \
    apt-get -y --no-install-recommends install php-mysql php-xml \
        php-json php-curl php-intl \
        ffmpeg php-gd git timidity && \
    apt-get -y -u dist-upgrade && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY setup/ /tmp/setup/
RUN /tmp/setup/setup.sh
RUN cd /var/www/html/ampache && \
    mkdir lib/vendor lib/components && \
    chown www-data lib/vendor lib/components && \
    su www-data -s /bin/bash -c 'composer install --prefer-source --no-interaction' && \
    chown -R www-data:www-data /var/www/html/ampache
RUN cd /var/www/html/ampache && \
    for DIR in rest play channel; do mv -v $DIR/.htaccess.dist $DIR/.htaccess; done
COPY 99-ampache.ini /etc/php/7.4/apache2/conf.d/
RUN a2enmod rewrite && \
    a2enmod ssl && \
    ln -s html/ampache /var/www/ampache
# Mark things writable.  This list is in lib/debug.lib.php
# For auto-update to work, the entire thing has to be owned by www-data
RUN chown -R www-data /var/www/html/ampache
# Compatibility - avconv was available in stretch; in buster, it's
# all ffmpeg.  For existing configs that use it:
RUN ln -s ffmpeg /usr/bin/avconv
RUN /usr/local/bin/docker-wipelogs
RUN mv /usr/sbin/policy-rc.d /usr/sbin/policy-rc.d.disabled

EXPOSE 80 443 81
VOLUME ["/var/www/html/ampache/config"]
CMD ["/usr/local/bin/boot-debian-base"]

