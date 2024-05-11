#!/bin/bash

#PROJECT_DIR="sf-victn-diploma-0-app1"
PROJECT_DIR=${PWD##*/}
LOG_FILE="_logs/fake.log"
COMMIT_MESSAGE="step02: fakeChanges"


## Adds fake changes to code for cicd testing
#
#..make changes
echo "[$(date +'%Y-%m-%dT%H:%M:%S')] :: fake changes v$(date +'%Y%m%d_%H%M%S')" >> $LOG_FILE

#..send changes to repo
clear
git status
echo ---
git add .
git commit -m "${COMMIT_MESSAGE}"
git push
echo ---
git status
