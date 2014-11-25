FROM docker_quickstart/base:SOAPBASEVER
MAINTAINER Sumit Datta <sumitdatta@gmail.com>

ENTRYPOINT cat /app/config/ssh_default.pub >> /root/.ssh/authorized_keys && \
    /usr/sbin/sshd -D -e