FROM docker_quickstart/base:VER_BASE
MAINTAINER Sumit Datta <sumitdatta@gmail.com>

ENV VENVDIR /venv

ENTRYPOINT if [ ! -f $VENVDIR/bin/activate ]; then virtualenv $VENVDIR; fi && \
    . $VENVDIR/bin/activate && \
    pip install -r /app/requirements/dev.txt && \
    python /app/backend/manage.py collectstatic --noinput && \
    mysql -u root -proot -h mysqlhost -Bse "CREATE DATABASE IF NOT EXISTS backend;" && \
    python /app/backend/manage.py migrate && \
    ln -s /app/config/uwsgi-devel/backend.ini /etc/uwsgi/ && \
    uwsgi --emperor /etc/uwsgi/

EXPOSE 9000
