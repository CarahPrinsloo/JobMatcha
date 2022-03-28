#!/bin/bash

setup_client(){
  cd client-app
  echo "------------------------------------------------------------"
  echo "Preparing the client for release"
  echo "------------------------------------------------------------"
  flutter clean
  flutter pub get
  flutter build apk
  echo "-------------------------------------------------------------"
  cp client-app/build/app/outputs/apk/release/app-release.apk .
}

setup_server(){
  cd server
  echo "------------------------------------------------------------"
  echo "Preparing the server for release"
  echo "------------------------------------------------------------"
  mvn clean package
  echo "-------------------------------------------------------------"
}

run_client() {
  cd client-app
  echo "------------------------------------------------------------"
  echo "Running client"
  echo "------------------------------------------------------------"
  flutter run -d chrome --no-sound-null-safety
  echo "-------------------------------------------------------------"
}

run_server() {
  cd server
  echo "------------------------------------------------------------"
  echo "Running server"
  echo "------------------------------------------------------------"
  java -jar target/server-1.0-SNAPSHOT-jar-with-dependencies.jar
  echo "-------------------------------------------------------------"
}

run_client_tests() {
  cd client-app
  echo "------------------------------------------------------------"
  echo "Running client tests"
  echo "------------------------------------------------------------"
  flutter test
}

run_server_tests() {
  cd server
  echo "------------------------------------------------------------"
  echo "Running server tests"
  echo "------------------------------------------------------------"
  mvn test
}

case $1 in
 "setup_client") setup_client;;
 "setup_server") setup_server;;
 "run_client") run_client;;
 "run_server") run_server;;
 "run_client_tests") run_client_tests;;
 "run_server_tests") run_server_tests;;
esac

