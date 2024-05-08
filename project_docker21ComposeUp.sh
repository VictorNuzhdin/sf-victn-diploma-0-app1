#!/bin/bash

PROJECT_DIR=${PWD##*/}
APP_CONTAINER_NAME="my-django-webapp"
APP_STATIC_FILES_VOLUME_NAME="webapp-static"
APP_STATIC_FILES_LOCAL_PATH="/opt/webapps/static"
WAIT_TIME_SEC="15"
#
#
#

#--
clear

#..Creates local directory and Docker Volume for store static files from webapp Container
#  *reverse mounting technique: from container to host
#  *example:
#   docker volume create --opt type=none --opt o=bind --opt device=/opt/webapps/static webapp-static
#
sudo rm -rf $APP_STATIC_FILES_LOCAL_PATH
sudo mkdir -p $APP_STATIC_FILES_LOCAL_PATH
docker volume create --opt type=none --opt o=bind --opt device=$APP_STATIC_FILES_LOCAL_PATH $APP_STATIC_FILES_VOLUME_NAME

export APP_STATIC_FILES_VOLUME_NAME=${APP_STATIC_FILES_VOLUME_NAME}


#..Runs Docker Compose Stack
echo
echo "--Running All Containers.."
echo
##..BAD_SOLUTION_BELOW
##..init_cold_start
docker compose up --detach
#sleep $WAIT_TIME_SEC
#docker compose down
#
##..next_hot_start
#sleep $WAIT_TIME_SEC
#docker compose up --detach


#..cheks docker build/run results
./project_docker00Show.sh


#..Connects to Webapp Container console
#sleep ${WAIT_TIME_SEC}
#docker exec -it $APP_CONTAINER_NAME bash
