Infobright Enterprise Edition (IEE) Docker Container
=================

Infobright is a MySQL Database Engine. See http://www.infobright.org/ for more details.
This container was based on the [mysql container](https://registry.hub.docker.com/_/mysql/)

## Usage: 

    cp ~/Downloads/iblicense-*.lic ./iblicense.lic
    cp ~/Downloads/infobright-*.deb ./
    docker build -t infobright-iee .
    docker run --name mysql_ib_iee -e MYSQL_ROOT_PASSWORD=<pass> -v <datadir>:/mnt/mysql_iee_data -p 6029:5029 -d infobright-iee

See container at: https://registry.hub.docker.com/u/meatcar/infobright/
