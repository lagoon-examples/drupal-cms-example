FROM uselagoon/php-8.3-cli-drupal:latest AS cli

COPY composer.json /app
COPY .lagoon/assets /app/assets
COPY config /app/config

ADD https://git.drupalcode.org/project/drupal_cms.git#0.x /app/drupal_cms

RUN composer install --no-dev
# RUN composer install --no-dev \
#     && composer config extra.drupal-scaffold --unset

RUN mkdir -p -v -m775 /app/web/sites/default/files \
    && fix-permissions /app/web/sites/default/files \
    && fix-permissions /app/vendor \
    && fix-permissions /app/web

# Define where the Drupal Root is located
ENV WEBROOT=web

FROM uselagoon/nginx-drupal:latest AS nginx

COPY --from=cli /app /app

ENV WEBROOT=web

FROM uselagoon/php-8.3-fpm:latest AS php
 
COPY --from=cli /app /app

ENV PATH="$PATH:/app/vendor/bin:/home/.composer/vendor/bin"

RUN apk add --no-cache \
    rsync
