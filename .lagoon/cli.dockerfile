FROM uselagoon/php-8.3-cli-drupal:latest

COPY composer.json /app
COPY .lagoon/assets /app/assets
COPY .lagoon/scripts /app/scripts
COPY config /app/config

ADD https://git.drupalcode.org/project/drupal_cms.git#0.x /app/drupal_cms

RUN /app/scripts/refresh-components \
    && composer install --no-dev

RUN mkdir -p -v -m775 /app/web/sites/default/files

# Define where the Drupal Root is located
ENV WEBROOT=web
