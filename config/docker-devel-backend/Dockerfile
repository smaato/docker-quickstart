FROM docker_quickstart/base:SOAPBASEVER
MAINTAINER Sumit Datta <sumitdatta@gmail.com>

ENV VENVDIR /venv

ENTRYPOINT if [ ! -f $VENVDIR/bin/activate ]; then virtualenv $VENVDIR; fi && \
    . $VENVDIR/bin/activate && \
    pip install -r /app/requirements/dev.txt && \
    python /app/django/manage.py collectstatic --noinput && \
    ln -s /app/config/uwsgi-devel/backend.ini /etc/uwsgi/ && \
	mysql -u root -proot -h mysqlhost -Bse "CREATE DATABASE IF NOT EXISTS backend;" && \
    uwsgi --emperor /etc/uwsgi/

EXPOSE 9000
