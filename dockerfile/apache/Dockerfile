FROM webdevops/apache:ubuntu-18.04

LABEL maintainer="Eric Pfeiffer <computerfr33k@users.noreply.github.com>"

#####################################
# Set Timezone
#####################################

ARG TZ=UTC
ENV TZ ${TZ}

ARG DOCUMENT_ROOT=/var/www/
ARG PHP_UPSTREAM_CONTAINER=php-fpm
ARG PHP_UPSTREAM_PORT=9000
ARG PHP_UPSTREAM_TIMEOUT=60
ARG APACHE_INSTALL_HTTP2=false

ENV WEB_PHP_SOCKET=${PHP_UPSTREAM_CONTAINER}:${PHP_UPSTREAM_PORT}
ENV WEB_DOCUMENT_ROOT=${DOCUMENT_ROOT}
ENV APACHE_HTTP2=${APACHE_INSTALL_HTTP2}
ENV WEB_PHP_TIMEOUT=${PHP_UPSTREAM_TIMEOUT}

ENV LOG_STDOUT=/var/log/apache2/access.log

ENV LOG_STDERR=/var/log/apache2/error.log

# 设置上海时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    sed -i '/nodaemon=true/alogfile=\/var\/log\/supervisord.log' /opt/docker/etc/supervisor.conf && \
    sed -i '/nodaemon=true/apidfile=\/var\/run\/supervisord.pid' /opt/docker/etc/supervisor.conf

EXPOSE 80 443

WORKDIR /var/www/

COPY vhost.conf /etc/apache2/sites-enabled/vhost.conf

ADD ./startup.sh /opt/startup.sh

ENTRYPOINT ["/opt/docker/bin/entrypoint.sh"]

CMD ["/bin/bash", "/opt/startup.sh"]

EXPOSE 80 443