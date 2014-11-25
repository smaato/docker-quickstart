FROM debian:jessie
MAINTAINER Sumit Datta <sumitdatta@gmail.com>

# Update package list, upgrade
# Install python3-pip and virtualenv
# Clean up APT when done
RUN apt-get update && \
    apt-get -y -q upgrade && \
    apt-get install --no-install-recommends -q -y \
        python \
        python-pip \
        uwsgi-plugin-python \
        git \
        openssh-server \
        openssh-sftp-server \
        nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD requirements/app /app

# Install all of the dependencies of the project
RUN pip install virtualenv && \
    if [ ! -f /venv/bin/activate ]; then virtualenv /venv; fi && \
    . /venv/bin/activate && \
    pip install -r /app/requirements/production.txt && \
    mkdir -p /var/log/uwsgi && \
    mkdir /etc/uwsgi && \
    mkdir /var/run/sshd && \
    chown -R www-data:www-data /var/log/uwsgi/ && \
    mkdir /root/.ssh && \
    touch /root/.ssh/authorized_keys

# RUN /bin/bash