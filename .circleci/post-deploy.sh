#!/bin/bash

ssh $APP_USER@$APP_HOST <<ENDSSH
  echo "changing dir to ./apps/$APP_NAME"
  cd ./apps/$APP_NAME;
  date >> deploy-log.txt;

  echo "stopping previous deploy";
  ./bin/$APP_NAME stop >> deploy-log.txt || true;
  echo "starting new deploy";
  ./bin/$APP_NAME start >> deploy-log.txt || true;
ENDSSH
