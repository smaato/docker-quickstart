#!/bin/bash
source containers.sh

build_base

build_devel_backend

build_devel_ssh

build_devel_webserver
