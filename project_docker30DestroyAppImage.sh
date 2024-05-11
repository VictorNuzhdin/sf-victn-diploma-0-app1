#!/bin/bash

PROJECT_DIR=${PWD##*/}
REPO_LOGIN="dotspace2019"
REPO_NAME="nve-diploma-webapp"
#
#APP_VERSION_0="2024.0505.220527"
#APP_VERSION_1="latest"
#APP_VERSION_2="dev"
APP_VERSION_3="test"
#

#--
clear

echo "--Removing Docker Images and Clear Build Cache.."
echo
echo "..Removing Images.."
echo
#docker rmi ${REPO_LOGIN}/${REPO_NAME}:${APP_VERSION_0}
#docker rmi ${REPO_LOGIN}/${REPO_NAME}:${APP_VERSION_1}
#docker rmi ${REPO_LOGIN}/${REPO_NAME}:${APP_VERSION_2}
docker rmi ${REPO_LOGIN}/${REPO_NAME}:${APP_VERSION_3}
#docker rmi ${REPO_NAME}:${APP_VERSION_3}
#
echo
echo

#echo "..Clearing Docker Build Cache.."
##      https://docs.docker.com/reference/cli/docker/builder/prune/
#echo
docker builder prune --all --force
#echo
#echo

#echo "..Clearing Docker System.."
#echo
#docker system prune --all --force
#echo
#echo

#..cheks docker build/run results
./project_docker00Show.sh
