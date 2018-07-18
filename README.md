# Apache docker image

This creates a docker image based on ubuntu:16.04 that runs apache and php7.1.

## Building the image

The following command will create the image and tag it `apache`. Of course, you can tag it whatever you want just remember the tag for the next command.

```
docker build -t apache .
```

### apache.conf

This projects contains an apache.conf file. This file will get moved to `/etc/apache2/sites-available/000-default.conf` and will become the your default apache configuration. Feel free to edit this file in anyway to add the settings you may need apache to have. Right now its configured for applications that require followsymlinks such as laravel, wordpress or drupal.

## Mounting a directory

This image is configured to run apache with the document root set to `/var/www/app`. When mounting a volume, mount your directory to this directory. example:


```
docker run --name apache -d --mount type=bind,source="$(pwd -P)",target=/var/www/app apache
```

This command runs a container with your current working directory mounted to `/var/www/app`. It also names the container `apache`. I find using names useful for when I need to remove the container or stop it. Totally up to you if you want to use it.
