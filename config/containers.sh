#!/bin/bash
CONFDIR='/app/config'
APPDIR=`dirname $CONFDIR`
REGISTRY="brainless"

VER_BASE="0.1"
VER_DEVEL_BACKEND="0.1"
VER_DEVEL_WEBSERVER="0.1"
VER_DEVEL_SSH="0.1"


build() {
    cd $CONFDIR/docker-$1
    sudo docker build -t $REGISTRY/$1:$2 .

    rm -rf $CONFDIR/docker-$1/requirements
    cd $CONFDIR
}

#--------------------------------------------------------------------------------#
# Base image that has all our needed software, but does not run anything
#--------------------------------------------------------------------------------#

build_base() {
    NAME=base
    VERSION=$VER_BASE

    mkdir -p $CONFDIR/docker-$NAME/requirements

    cd $APPDIR
    git archive --prefix=app/ HEAD | (cd $CONFDIR/docker-$NAME/requirements/ && tar xf -)

    build $NAME $VERSION
}

#--------------------------------------------------------------------------------#
# Development related Docker build scripts
#--------------------------------------------------------------------------------#

build_devel_backend() {
    NAME=devel-backend
    VERSION=$VER_DEVEL_BACKEND

    sed -i 's/:VER_BASE/:'"$VER_BASE"'/g' $CONFDIR/docker-$NAME/Dockerfile
    build $NAME $VERSION
    sed -i 's/:'"$VER_BASE"'/:VER_BASE/g' $CONFDIR/docker-$NAME/Dockerfile
}

build_devel_webserver() {
    NAME=devel-webserver
    VERSION=$VER_DEVEL_WEBSERVER

    sed -i 's/:VER_BASE/:'"$VER_BASE"'/g' $CONFDIR/docker-$NAME/Dockerfile
    build $NAME $VERSION
    sed -i 's/:'"$VER_BASE"'/:VER_BASE/g' $CONFDIR/docker-$NAME/Dockerfile
}

build_devel_ssh() {
    NAME=devel-ssh
    VERSION=$VER_DEVEL_SSH

    sed -i 's/:VER_BASE/:'"$VER_BASE"'/g' $CONFDIR/docker-$NAME/Dockerfile
    build $NAME $VERSION
    sed -i 's/:'"$VER_BASE"'/:VER_BASE/g' $CONFDIR/docker-$NAME/Dockerfile
}

#--------------------------------------------------------------------------------#
# MongoDB Docker run script
#--------------------------------------------------------------------------------#

run_mysqlhost() {
    cd $CONFDIR
    mkdir -p /tmp/data/db
    sudo docker run --name mysqlhost -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root mysql:5.5
}

#--------------------------------------------------------------------------------#
# Development related Docker run scripts
#--------------------------------------------------------------------------------#

run_devel_backend() {
    NAME=devel-backend

    mkdir -p $CONFDIR/logs
    sudo docker run \
        --link mysqlhost:mysqlhost \
        -v $APPDIR:/app \
        -v $CONFDIR/logs:/logs \
        -d \
        -h $NAME \
        --name $NAME \
        $REGISTRY/$NAME:$VER_DEVEL_BACKEND
}

run_devel_webserver() {
    NAME=devel-webserver

    sudo docker run \
        --link devel-backend:devel-backend \
        --volumes-from devel-backend \
        --name $NAME \
        -d \
        -p 80:80 \
        $REGISTRY/$NAME:$VER_DEVEL_WEBSERVER
}

run_devel_ssh() {
    NAME=devel-ssh

    sudo docker run \
        --link mysqlhost:mysqlhost \
        --volumes-from devel-backend \
        --name $NAME \
        -d \
        -p 22222:22 \
        -p 8000:8000 \
        -h $NAME \
        $REGISTRY/$NAME:$VER_DEVEL_SSH
}

stop_remove() {
    # @param $1: name of container to stop and remove
    if [ `sudo docker ps | grep $1 | wc -l` -ne 0 ]; then
        sudo docker stop $1
    fi
    if [ `sudo docker ps -a | grep $1 | wc -l` -ne 0 ]; then
        sudo docker rm $1
    fi
    sleep 2
}