#!/bin/bash
CONFDIR='/app/config'

source $CONFDIR/containers.sh

run_mysqlhost

run_devel_backend

run_devel_ssh

run_devel_webserver
