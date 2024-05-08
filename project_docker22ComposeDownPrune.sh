#!/bin/bash

PROJECT_DIR=${PWD##*/}
APP_STATIC_FILES_VOLUME_NAME="webapp-static"
APP_STATIC_FILES_LOCAL_DIR="/opt/webapps"
APP_STATIC_FILES_LOCAL_PATH="/opt/webapps/static"
#
#
#
#

#--
clear

echo "--Stopping Docker/Compose Stack and Removing All artifacts.."
echo
echo "..Stopping Compose Stack.."
echo
docker compose down
echo
echo

echo "..Removing Docker Containers.."
echo
docker container prune --force
echo
echo

echo "..Removing Docker Volumes.."
echo
docker volume rm ${PROJECT_DIR}_appdata
docker volume rm ${PROJECT_DIR}_pgdata
docker volume rm ${APP_STATIC_FILES_VOLUME_NAME}
echo
docker volume prune --force
echo
echo

echo "..Removing deployed webapp static files dir from localhost ${APP_STATIC_FILES_LOCAL_DIR}.."
echo
sudo rm -rf ${APP_STATIC_FILES_LOCAL_PATH}
ls ${APP_STATIC_FILES_LOCAL_DIR}
echo
echo

#..cheks docker build/run results
./project_docker00Show.sh
