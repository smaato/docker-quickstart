FROM docker_quickstart/base:SOAPBASEVER
MAINTAINER Smaato

ENTRYPOINT cp /app/config/nginx/nginx.conf /etc/nginx/nginx.conf && \
    ln -s /app/nginx.local/api.soap.conf /etc/nginx/sites-enabled/ && \
    ln -s /app/nginx.local/portal.soap.conf /etc/nginx/sites-enabled/ && \
    rm /etc/nginx/sites-enabled/default && \
    /usr/sbin/nginx -c /etc/nginx/nginx.conf
