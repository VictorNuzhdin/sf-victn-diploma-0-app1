##..selects base image
FROM python:3.11-slim 
#-bullseye

##..sets system environment vars
ARG DEBIAN_FRONTEND="noninteractive"
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PYTHONPATH "${PYTHONPATH}:/app"
ENV PYTHONPATH "${PYTHONPATH}:/app/webapp"

##..sets django webapp environment vars (low_security)
#ENV SECRET_KEY="secret"
#ENV DB_NAME="djangoapp"
#ENV DB_USER="postgres"
#ENV DB_PASSWORD="postgres"
#ENV DB_HOST="pgserver"
#ENV DB_PORT="5432"

##..sets django webapp environment vars (hi_security)
#ENV SECRET_KEY='$cl0&SED_!80$'                     ## django app crashes and restarts
ENV SECRET_KEY="veRyseCretFUckinGshItBigGOvnoKey"
ENV DB_NAME="djangoapp"
ENV DB_USER="guandon"
ENV DB_PASSWORD="cl0&SED_@80"
ENV DB_HOST="pgserver"
ENV DB_PORT="7856"
#
ENV WEBAPP_SQL_DATA_FILE="djangoapp_data.sql"


##..copies files from local dir to image dir
WORKDIR .
COPY ./app/requirements.txt /app/

##..installs tools and pstgresql-16 client
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
    lsb-release \
    curl \
    ca-certificates \
    iputils-ping && \
    install -d /usr/share/postgresql-common/pgdg && \
    curl -s -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc && \
    sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
    apt-get update && \
    apt-get install -y postgresql-client-16 && \
    apt-get clean all

##..installs python components
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        python3-pip \
        libpq-dev \
        python3-psycopg2 \
        build-essential \
        libssl-dev \
        libffi-dev \
        python3-dev \
        python3-venv && \
    apt-get clean all

##..updates python pip and setuptools to latest version
RUN pip3 install --upgrade pip && \
    pip3 install --upgrade setuptools

##..installs python app dependencies from the "requirements" file
RUN pip install -r /app/requirements.txt

##..copies webapp code to image
COPY ./app/. /app/
COPY ./sql/djangoapp_data.sql /app/sql/djangoapp_data.sql
COPY ./sql/djangoapp_data_inject.sh /app/sql/djangoapp_data_inject.sh

##..runs python django app
EXPOSE 8000
CMD python /app/manage.py runserver 0.0.0.0:8000
