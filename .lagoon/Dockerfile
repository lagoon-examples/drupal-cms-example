FROM uselagoon/php-8.3-cli-drupal:latest AS cli

RUN mkdir -p -v -m775 /app2

COPY composer.* /app2
COPY assets /app2/assets
COPY config /app2/config

ADD https://git.drupalcode.org/project/drupal_cms.git#0.x /app2/drupal_cms

# RUN composer install --no-dev
# RUN composer install --no-dev \
#     && composer config extra.drupal-scaffold --unset

RUN mkdir -p -v -m775 /app/web/sites/default/files \
    && fix-permissions /app/web/sites/default/files \
    && mkdir -p -v -m775 /app/vendor \
    && fix-permissions /app/vendor \
    && mkdir -p -v -m775 /app/web \
    && fix-permissions /app/web

# Define where the Drupal Root is located
ENV WEBROOT=web

FROM uselagoon/nginx-drupal:latest AS nginx

COPY --from=cli /app /app

ENV WEBROOT=web

FROM uselagoon/php-8.3-fpm:latest AS php
 
COPY --from=cli /app /app
COPY --from=cli /usr/local/bin/composer /usr/local/bin/composer

RUN apk add --no-cache \
    rsync
