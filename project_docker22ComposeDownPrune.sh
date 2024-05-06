#!/bin/bash

PROJECT_DIR=${PWD##*/}
#
#
#
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
docker volume prune --force
echo
echo


#..cheks docker build/run results
./project_docker00Show.sh
