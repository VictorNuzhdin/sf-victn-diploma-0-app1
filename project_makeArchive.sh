#!/bin/bash

#PROJECT_DIR="sf-victn-diploma-0-app1"
PROJECT_DIR=${PWD##*/}

cd ..

zip -r "$PROJECT_DIR"__v$(date +'%Y%m%d_%H%M%S').zip $PROJECT_DIR
