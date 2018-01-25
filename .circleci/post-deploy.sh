#!/bin/bash

ssh $APP_USER@$APP_HOST <<ENDSSH
  echo "changing dir to ./apps/$APP_NAME"
  cd ./apps/$APP_NAME;
  date >> deploy-log.txt;

  echo "stopping app";
  ./bin/$APP_NAME stop >> deploy-log.txt || true;
ENDSSH

ssh $APP_USER@$APP_HOST <<ENDSSH
  cd ./apps/$APP_NAME;
  date >> deploy-log.txt;

  echo "starting app";
  ./bin/$APP_NAME start >> deploy-log.txt;

  echo "Finished";
ENDSSH
