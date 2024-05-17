#!/bin/bash

#PROJECT_DIR="sf-victn-diploma-0-app1"
PROJECT_DIR=${PWD##*/}
LOG_FILE="_logs/fake.log"
#
RELEASE_VERSION="0.0.1"
COMMIT_MESSAGE="step02: release $RELEASE_VERSION"



## Adds fake changes to code for cicd testing
#
#..make changes
echo "[$(date +'%Y-%m-%dT%H:%M:%S')] :: $COMMIT_MESSAGE" >> $LOG_FILE
#echo "[$(date +'%Y-%m-%dT%H:%M:%S')] :: fake changes v$(date +'%Y%m%d_%H%M%S')" >> $LOG_FILE

#..send changes to repo
clear
git status
echo ---
git add .
git commit -m "$COMMIT_MESSAGE" -m "Release-As: $RELEASE_VERSION"
#git commit --allow-empty -m "step02: release 0.0.1" -m "Release-As: 0.0.1"
#git commit -m "${COMMIT_MESSAGE}"
git push
echo ---
git status
