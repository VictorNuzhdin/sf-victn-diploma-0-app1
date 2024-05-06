#!/bin/bash

DOCKER_REPO="dotspace2019"
APP_NAME="nve-diploma-webapp"
APP_TAG="latest"
IMAGE_FULL_NAME="$DOCKER_REPO/$APP_NAME:$APP_TAG"
APP_CONTAINER_NAME="my-django-webapp"
APP_INTERNAL_PORT="8000"
APP_EXTERNAL_PORT="8000"
#
ENV_TZ="Asia/Omsk"
ENV_DB_HOST="pgserver"
ENV_DB_PORT="5432"
ENV_DB_NAME="djangoapp"
ENV_DB_USER="postgres"
ENV_DB_PASSWORD="postgres"
ENV_SECRET_KEY="secret"
ENV_SQL_DATA_FILE="djangoapp_data.sql"
#

##..tests
#echo $IMAGE_FULL_NAME
#exit

#--
clear

#..Runs webapp container from docker image
echo
echo "--Running Webapp Container.."
echo
echo "..Creating named Docker Volume.."
docker volume create --name vol-${APP_CONTAINER_NAME}
echo

echo "..Running Webapp Container.."
docker run --rm -d -p $APP_INTERNAL_PORT:$APP_EXTERNAL_PORT \
--name ${APP_CONTAINER_NAME} \
-e TZ=${ENV_TZ} \
-e DB_HOST=${ENV_DB_HOST} \
-e DB_PORT=${ENV_DB_PORT} \
-e DB_NAME=${ENV_DB_NAME} \
-e DB_USER=${ENV_DB_USER} \
-e DB_PASSWORD=${ENV_DB_PASSWORD} \
-e SECRET_KEY=${ENV_SECRET_KEY} \
-e SQL_DATA_FILE=${ENV_SQL_DATA_FILE} \
-v vol-${APP_CONTAINER_NAME}:/opt/${APP_CONTAINER_NAME} ${IMAGE_FULL_NAME}
echo


#..cheks docker build/run results
./project_docker00Show.sh


#..Connects to containers console
docker exec -it ${APP_CONTAINER_NAME} bash
