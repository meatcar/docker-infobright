Infobright Community Edition (ICE) Docker Container
=================

Infobright is a MySQL Database Engine. See http://www.infobright.org/ for more details.
This container was based on the [mysql container](https://registry.hub.docker.com/_/mysql/)

## Usage: 

    docker run --name mysql-ib -e MYSQL_ROOT_PASSWORD=<mysecretpassword> /my/fav/data/dir:/mnt/mysql_data -d infobright

See container at: https://registry.hub.docker.com/u/meatcar/infobright/
