FROM docker_quickstart/base:SOAPBASEVER
MAINTAINER Sumit Datta <sumitdatta@gmail.com>

ENV VENVDIR /venv

#ENTRYPOINT if [ ! -f $VENVDIR/bin/activate ]; then virtualenv $VENVDIR; fi && \
#    . $VENVDIR/bin/activate && \
#    pip install -r /app/requirements/dev.txt && \
#    python /app/django/manage.py collectstatic --noinput && \
#    ln -s /app/config/uwsgi.local/soap.ini /etc/uwsgi/ && \
#    uwsgi --emperor /etc/uwsgi/

ENTRYPOINT if [ ! -f $VENVDIR/bin/activate ]; then virtualenv $VENVDIR; fi && \
    . $VENVDIR/bin/activate && \
    pip install -r /app/requirements/dev.txt && \
    /bin/bash

EXPOSE 9000
