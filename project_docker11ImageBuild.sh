#!/bin/bash

#..sets current Django App and Docker Image tag version and saves it to file (example: 2024.0504.200753)
VERSION_FILE="app/webapp/APP_VERSION"
VERSION_NOW="$(date +'%Y.%m%d.%H%M%S')"
DOCKER_REPO="dotspace2019"
APP_NAME="nve-diploma-webapp"
#APP_NAME="nve-diploma-webapp"
#APP_NAME="django-greetings"
APP_TAG_0="$VERSION_NOW"
APP_TAG_1="latest"
APP_TAG_2="dev"

#--
clear

#..Writes NEW version to file
echo -n $VERSION_NOW > $VERSION_FILE

##..tests
#echo $DOCKER_REPO/$APP_NAME:$APP_TAG_0      ## dotspace2019/django-greetings:2024.0504.201907
#echo $DOCKER_REPO/$APP_NAME:$APP_TAG_1      ## dotspace2019/django-greetings:latest


#..builds docker image from dockerfile
echo
echo "--Building Webapp Docker Image.."
docker build -t ${APP_NAME}:${APP_TAG_2} .
#docker build -t ${DOCKER_REPO}/${APP_NAME}:${APP_TAG_0} -t ${DOCKER_REPO}/${APP_NAME}:${APP_TAG_1} .
#docker build -t ${DOCKER_REPO}/${APP_NAME}:${APP_TAG_0} -t ${DOCKER_REPO}/${APP_NAME}:${APP_TAG_1} -t ${DOCKER_REPO}/${APP_NAME}:${APP_TAG_2} .
echo


#..cheks docker build/run results
./project_docker00Show.sh
