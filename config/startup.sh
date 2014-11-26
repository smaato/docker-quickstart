#!/bin/bash
CONFDIR='/app/config'

source $CONFDIR/containers.sh

stop_remove mysqlhost
run_mysqlhost

stop_remove devel-backend
run_devel_backend

stop_remove devel-ssh
run_devel_ssh

stop_remove devel-webserver
run_devel_webserver
