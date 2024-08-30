# Lagoon Drupal CMS example

This project is a wrapper around the [Drupal Starshot](https://www.drupal.org/about/starshot) initiative.

It uses the [Drupal CMS](https://www.drupal.org/project/drupal_cms) default download to provision a Drupal Site.

As of August 2024 it doesn't support local development, Project Browser or Automated Updates.

To get started:
```
docker compose build
docker compose up -d
docker compose exec cli bash -c 'wait-for mariadb:3306'
docker compose exec cli bash -c 'drush -y si && drush -y cr'
echo "visit http://$(docker compose port nginx 8080) to see your site"
```

Any modules required can be added to the root composer.json in this directory and then the site can be rebuilt:
```
composer require --no-update drupal/XXX
docker compose build
docker compose up -d
docker compose exec cli bash -c 'wait-for mariadb:3306'
docker compose exec cli bash -c 'drush -y updb && drush -y cr'
echo "visit http://$(docker compose port nginx 8080) to see your site"
```
