# Apache docker image

This creates a docker image based on ubuntu:16.04 that runs apache and php7.1.

## Building the image

The following command will create the image and tag it `apache`. Of course, you can tag it whatever you want just remember the tag for the next command.

```
docker build -t apache .
```

By default the documentroot is set to `/var/www/app` but if you wish to build with a different document root, you can set a build argument named `documentroot` to which ever directory you want like so:

```
docker build -t apache --build-arg documentroot=/var/www/app/public .
```

### apache.conf

This projects contains an apache.conf file. This file will get moved to `/etc/apache2/sites-available/000-default.conf` and will become the your default apache configuration. Feel free to edit this file in anyway to add the settings you may need apache to have. Right now its configured for applications that require followsymlinks such as laravel, wordpress or drupal.

In this file I am utilizing the apache environment variable `APACHE_DOCUMENTROOT` to have the virtualhost automatically follow the document root to which ever directory we set it to be in the build command.

## Mounting a directory

This image is configured to run apache with the document root set to `/var/www/app`. When mounting a volume, mount your directory to this directory. example:


```
docker run --name apache -d --mount type=bind,source="$(pwd -P)",target=/var/www/app apache
```

This command runs a container with your current working directory mounted to `/var/www/app`. It also names the container `apache`. I find using names useful for when I need to remove the container or stop it. Totally up to you if you want to use it.
