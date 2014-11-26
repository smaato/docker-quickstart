#!/bin/bash
HOST='192.168.150.150'
USER='root'
PORT='22222'

connect() {
    if [ -f ssh_key.pub ]; then
        echo "Using your custom SSH key"
        chmod 600 ssh_key
        ssh -q -o UserKnownHostsFile=/dev/null -p $PORT -o StrictHostKeyChecking=no -i ssh_key $USER@$HOST
    else
        echo "Using the default SSH key."
        chmod 600 ssh_default
        ssh -q -o UserKnownHostsFile=/dev/null -p $PORT -o StrictHostKeyChecking=no -i ssh_default $USER@$HOST
    fi
}

connect