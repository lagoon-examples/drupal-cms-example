#!/bin/sh

FLAG_FILE="/app/scaffolding_done.flag"

cd /app

# Check if the flag file exists
if [ ! -f "$FLAG_FILE" ]; then
    echo "*** NO SCAFFOLD FILE FOUND ***"
    git config --global --add safe.directory /app
    composer install --no-dev
    # Create the flag file to indicate the script has run
    echo "About to create $FLAG_FILE"
    touch "$FLAG_FILE"
else
    echo "*** SCAFFOLD FILE FOUND ***"
    echo "The initialization script has already run."
fi

# We attempt to copy the configuration settings into the appropriate location
# This may run in several circumstances, locally,
if [ ! -f "/app/web/sites/default/settings.php" ]; then
    # First, we copy in the default settings from the composer installed drupal_integrations
    cp /app/drush/Commands/contrib/drupal_integrations/assets/* /app/web/sites/default
    # Second, we move over anything from our assets that we may want to use to override/supplement the defaults
    cp /app/.lagoon/assets/* /app/web/sites/default
    # Finally, we enable the lagoon settings for the site
    mv /app/web/sites/default/initial.settings.php /app/web/sites/default/settings.php
fi
