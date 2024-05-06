#!/bin/sh

##..required_env_variables (examples)
#
#DB_HOST=pgserver
#DB_PORT=5432
#DB_NAME=djangoapp
#DB_USER=postgres
#DB_PASSWORD=postgres
#SQL_DATA_FILE=djangoapp_data.sql


##..injects SQL data from file to DataBase on PostgreSQL server
#
psql postgres://$DB_HOST:$DB_PORT/$DB_NAME?sslmode=disable --username=$DB_USER --file="sql/$SQL_DATA_FILE"
#
##..example:
#psql postgres://pgserver:5432/djangoapp?sslmode=disable --username=postgres --file=./app/sql/djangoapp_data.sql
