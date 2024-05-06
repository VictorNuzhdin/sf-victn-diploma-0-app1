#!/bin/bash

PROJECT_DIR=${PWD##*/}
APP_CONTAINER_NAME="my-django-webapp"
#APP_CONTAINER_NAME="my-pgsrv"
WAIT_TIME_SEC="15"
#
#
#
#

#--
clear

#..Runs Docker Compose Stack
echo
echo "--Running All Containers.."
echo
docker compose up --detach


#..cheks docker build/run results
./project_docker00Show.sh


#..Connects to Webapp Container console
sleep ${WAIT_TIME_SEC}
