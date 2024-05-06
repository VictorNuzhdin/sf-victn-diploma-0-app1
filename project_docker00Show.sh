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
#clear

#..Checks Docker/Compose build/run/up Results
echo
echo "--Checking Docker Images, Containers and Volumes.."
echo
echo "--Docker Images"
echo
docker images
echo
echo
echo "--Docker Containers"
echo
docker ps -a
echo
echo
echo "--Docker Volumes :: Objects"
echo
docker volume ls
echo
echo
echo "--Docker Volumes :: Directories"
echo
sudo -i ls -1X /var/lib/docker/volumes
#sudo -i ls /var/lib/docker/volumes/vol-${APP_CONTAINER_NAME}/_data
echo
echo
