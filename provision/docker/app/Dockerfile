FROM python:3.6.1-alpine
MAINTAINER Luis Mayta <@slovacus>

LABEL NAME python
LABEL VERSION 3.6.1

ENV PACKAGES nginx supervisor bash git libmagic
ENV PACKAGES_DEPENDENCES git \
            gcc \
            make \
            musl-dev \
            libc-dev \
            libmagic \
            gcc \
            zlib-dev \
            linux-headers \
            build-base \
            musl \
            musl-dev \
            build-base \
            openssl \
            pcre-dev
# By default, allow unlimited file sizes, modify it to limit the file sizes
# To have a maximum of 1 MB (Nginx's default) change the line to:
# ENV NGINX_MAX_UPLOAD 1m
ENV NGINX_MAX_UPLOAD 0

COPY ./requirements/ /usr/src/requirements/
COPY ./requirements.txt /usr/src/requirements.txt

RUN apk add --update --no-cache --virtual .build-deps \
    $PACKAGES_DEPENDENCES \
    && pip install --force-reinstall -r /usr/src/requirements.txt \
    && find /usr/local \
        \( -type d -a -name test -o -name tests \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    && runDeps="$( \
        scanelf --needed --nobanner --recursive /usr/local \
                | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
                | sort -u \
                | xargs -r apk info --installed \
                | sort -u \
    )" \
    && apk add --virtual .rundeps $runDeps \
    && apk del .build-deps \
    && apk add --update --no-cache $PACKAGES \
    # nginx
    && mkdir -p /run/nginx \
    && mkdir -p /var/lib/nginx \
    && mkdir -p /var/lib/nginx/tmp \
    # forward request and error logs to docker log collector
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    # Remove default configuration from Nginx
    && rm -rf /etc/nginx/conf.d/default.conf

# Copy the modified Nginx conf
COPY provision/docker/templates/etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY provision/docker/templates/etc/nginx/conf.d/nginx.conf /etc/nginx/conf.d/
# Custom Supervisord config
COPY provision/docker/templates/etc/supervisord.conf /etc/
COPY provision/docker/templates/etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

# Copy the entrypoint that will generate Nginx additional configs
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# Add demo app
COPY ./ /usr/src
WORKDIR /usr/src

CMD ["/usr/bin/supervisord", "-n"]
