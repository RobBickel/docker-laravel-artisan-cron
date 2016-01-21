FROM dylanlindgren/docker-phpcli:latest
MAINTAINER	Dylan Miles <dylan.g.miles@gmail.com>

WORKDIR /tmp

# install required packages artisan
RUN apt-get update -y && \
    apt-get install -y \
    php5-curl \
    php5-mcrypt \
    php5-mongo \
    php5-mssql \
    php5-mysqlnd \
    php5-pgsql \
    php5-redis \
    php5-sqlite \
    php5-gd \
    php5-tidy

RUN mkdir -p /data
VOLUME ["/data"]
WORKDIR /data/web

# install required packages for cron
RUN		apt-get update -qq && \
		apt-get install -y \
					curl \
					wget && \
          apt-get clean autoclean && \
          apt-get autoremove --yes && \
          rm -rf /var/lib/{apt,dpkg,cache,log}/

ENV		GO_CRON_VERSION v0.0.7

RUN		curl -L https://github.com/odise/go-cron/releases/download/${GO_CRON_VERSION}/go-cron-linux.gz \
		| zcat > /usr/local/bin/go-cron \
		&& chmod u+x /usr/local/bin/go-cron

# install backup scripts
ADD		script-runner /usr/local/bin/script-runner

#18080 http status port
EXPOSE		18080

ADD		docker-entrypoint.sh /usr/local/sbin/docker-entrypoint.sh
ENTRYPOINT	["/usr/local/sbin/docker-entrypoint.sh"]

CMD		["go-cron"]
