FROM docker_quickstart/base:SOAPBASEVER
MAINTAINER Smaato

ENTRYPOINT cp /app/config/nginx-devel/nginx.conf /etc/nginx/nginx.conf && \
    ln -s /app/config/nginx-devel/frontend.conf /etc/nginx/sites-enabled/ && \
    rm /etc/nginx/sites-enabled/default && \
    /usr/sbin/nginx -c /etc/nginx/nginx.conf
