FROM ubuntu:14.04
MAINTAINER Tapti Palit <tpalit@cs.stonybrook.edu>

RUN apt-get update && apt-get install -y \
	build-essential \
	git \
	nginx \
	php5 php5-gd \
	php5-mysql php5-curl \
	php5-fpm php5-memcache	

# Increase the open file limit
COPY files/limits.conf.append /tmp/
RUN cat /tmp/limits.conf.append >> /etc/security/limits.conf && rm -f /tmp/limits.conf.append

# Checkout the Elgg installation
COPY files/elgg_installation /usr/share/nginx/html
RUN mv /usr/share/nginx/html/elgg_installation /usr/share/nginx/html/elgg

WORKDIR /usr/share/nginx/html
# Copy over the settings.php
COPY files/settings.php elgg/engine/settings.php

# Make the Elgg data directory
RUN mkdir /elgg_data
RUN chmod a+rw /elgg_data

# Copy over the Nginx Server configuration
COPY files/nginx_sites_avail.append /tmp/
RUN cat /tmp/nginx_sites_avail.append >> /etc/nginx/sites-available/default

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

CMD service php5-fpm start && service nginx start
