#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.

function echo-red     { COLOR='\033[31m' ; NORMAL='\033[0m' ; echo -e "${COLOR}$1${NORMAL}"; }
function echo-green   { COLOR='\033[32m' ; NORMAL='\033[0m' ; echo -e "${COLOR}$1${NORMAL}"; }
function echo-yellow  { COLOR='\033[33m' ; NORMAL='\033[0m' ; echo -e "${COLOR}$1${NORMAL}"; }
function echo-blue    { COLOR='\033[34m' ; NORMAL='\033[0m' ; echo -e "${COLOR}$1${NORMAL}"; }

echo-yellow "[ INFO ] started entrypoint.sh script"

init_db () {
  echo-yellow "[ INFO ] started init_db function"

  PATH_TO_SECRET_sa_password=/run/secrets/sa_password
  if [ ! -z ${PATH_TO_SECRET_sa_password+x} ]
  then
    PASS_TO_INIT=$(cat ${PATH_TO_SECRET_sa_password})
    echo-green "[ SUCCESS ] FINDED IN SECRETS PASSWORD='$PASS_TO_INIT'"
  else
    echo-red "[ ERROR ] DID NOT FINDED SECRET sa_password"
    PASS_TO_INIT=""
  fi


  INPUT_SQL_FILE="init-db.sql"
  until /opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U sa -P "$PASS_TO_INIT" -i $INPUT_SQL_FILE > /dev/null 2>&1
  do
    echo-red "SQL server is unavailable - password=$PASS_TO_INIT - sleeping 1 sec...."
    sleep 1 # Sleep for a second....
  done
  
  echo-green "Success initialized db"
}

init_db & /opt/mssql/bin/sqlservr