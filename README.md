# Lagoon Drupal CMS example

## Overview

This is an example project demonstrating how to set up a Drupal CMS based environment on Lagoon.

When running on a Lagoon instance, the first time that the project starts up, it will attempt to install Drupal CMS - see the `.lagoon.yml` file for how this is achieved using a post rollout task.

The `./.lagoon/scripts/scaffold.sh` script plays a key role in setting up the project, ensuring necessary dependencies and configurations are applied when running locally versus within Lagoon. See the file and the Dockerfile to see how this is achieved.

## Local Development

### How to Run Locally

To set up and run the project locally, after ensuring docker is running, execute the following commands:

```sh
pygmy up
docker compose build
docker compose up -d
docker compose exec cli bash -c 'wait-for mariadb:3306'
docker compose exec cli bash -c 'drush -y si && drush -y cr && drush uli'
```

(ignore the warnings referring to block plugins not being found. 
This is a known issue which will be fixed with this https://www.drupal.org/project/drupal/issues/3478773#comment-16090318)


These commands will:

1. Start Pygmy.
2. Build the necessary Docker containers.
3. Start the containers in detached mode.
4. Wait for the MariaDB service to become available.
5. Install Drupal and rebuild the cache using Drush.

### Using the Project Browser to install modules (Only Usable When Running Locally)

The Project Browser can be used to install modules through the UI when running locally. To do so:

1. Visit `/admin/modules/browse/drupalorg_jsonapi`.
2. Install a module using the UI.
3. This will update the `composer.json` and `composer.lock` files.
4. Commit these changes to the repository and push them up.
5. The module will still need to be enabled on the live site, but the composer packages will have been updated correctly.



## Technical Details

### `scaffold.sh` Script: Scaffolding Mechanism

The `scaffold.sh` script is responsible for initializing the Drupal project in both local and Lagoon environments. It primarily:

- Installs dependencies when running locally.
- Ensures required configurations and files are in place.
- Prevents reinstallation if scaffolding has already been completed.

#### Summary of Execution

- The script checks for the presence of `/app/scaffolding_done.flag`. If found, it skips execution.
- When running **locally**, it installs dependencies using `composer install --no-dev` and copies necessary configuration assets.
- When running **inside Lagoon**, it ensures required setup files exist but skips dependency installation.
- It is executed as part of the container's entrypoints, as defined in the Dockerfile.

### Disabling Project Browser Auto-Installation in Lagoon

To ensure a smooth setup in cloud environments, auto-installation of the Project Browser has been disabled when running in Lagoon. This prevents conflicts and ensures proper configuration management.

