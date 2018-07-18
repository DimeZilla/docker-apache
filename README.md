# Apache docker image

This creates a docker image based on ubuntu:16.04 that runs apache and php7.1.

## Building the image

The following command will create the image and tag it `apache`. Of course, you can tag it whatever you want just remember the tag for the next command.

```
docker build -t apache .
```

The build file accepts a `documentroot` argument to set the `APACHE_DOCUMENTROOT` environment variable. By default the document root is set to `/var/www/app` but if you wish to build with a different document root, you can set the build argument to which ever directory you want like so:

```
docker build -t apache --build-arg documentroot=/var/www/app/public .
```

### apache.conf

This projects contains an apache.conf file. This file will get moved to `/etc/apache2/sites-available/000-default.conf` and will become the default apache configuration. Feel free to edit this file in anyway to add the settings you may need apache to have. Right now its configured for applications that require followsymlinks such as laravel, wordpress or drupal.

In this file I am utilizing the apache environment variable `APACHE_DOCUMENTROOT` to have the virtualhost automatically follow the document root to which ever directory we set it to be in the build command. See "Building the image" above.

## Mounting a directory

This image is configured by default to run apache with the document root set to `/var/www/app`. When mounting a volume, mount your directory to this directory. example:


```
## using mount
docker run --name apache --mount type=bind,source="$(pwd -P)",target=/var/www/app apache
## using v
docker run --name apache -v $(pwd -P):/var/www/app apache
```

This command runs a container with your current working directory mounted to `/var/www/app`. It also names the container `apache`. I find using names useful for when I need to remove the container or stop it. Totally up to you if you want to use it.
