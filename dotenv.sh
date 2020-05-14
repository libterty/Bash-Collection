#!/bin/bash

# Generate Environment Script
dotenv() {
  touch .env

  echo "jwt=test" >>.env
  echo "username=LibTest" >>.env
  echo "password=12345678" >>.env
  echo "PROTOCOL=http" >>.env
  echo "IP=127.0.0.1" >>.env
  echo "PORT=5000" >>.env
  echo "DB_NAME=LibDB" >>.env
  echo "DB_PASS=12345678" >>.env

  echo Generate Config Finish
}

dotenv
