#!/bin/bash

APP_CONTAINER_NAME="my-django-webapp"
#
#
#
#
#
#
#

#--
clear

echo "..Stopping and Removing Webapp Container.."
docker stop ${APP_CONTAINER_NAME}
#docker rm ${APP_CONTAINER_NAME}
echo
echo

echo "..Removing Webapp Container artifacts.."
docker volume rm vol-${APP_CONTAINER_NAME}
docker volume prune --force
echo
echo

#..cheks docker build/run results
./project_docker00Show.sh
