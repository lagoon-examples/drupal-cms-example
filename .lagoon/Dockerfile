FROM testlagoon/php-8.5-cli-drupal:arm64-images AS cli

# set up scaffolding for drupal-cms
COPY .lagoon/scripts/scaffold.sh /lagoon/entrypoints/999-drupal-cms-scaffold.sh

COPY composer.* /app/
COPY assets /app/assets
COPY .lagoon /app/.lagoon

# Let the scaffolding file take care of running the install for us.
RUN /lagoon/entrypoints/999-drupal-cms-scaffold.sh
RUN mkdir -p -v -m775 /app/web/sites/default/


# Define where the Drupal Root is located
ENV WEBROOT=web

FROM uselagoon/nginx-drupal:latest AS nginx

COPY --from=cli /app /app

ENV WEBROOT=web

FROM testlagoon/php-8.5-fpm:arm64-images AS php
 
COPY --from=cli /app /app
# php-fpm needs to have the composer binary and rsync available
COPY --from=cli /usr/local/bin/composer /usr/local/bin/composer
