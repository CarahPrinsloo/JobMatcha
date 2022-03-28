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

build_server_docker_image() {
  cd server
  echo "------------------------------------------------------------"
  echo "Building server docker image"
  echo "------------------------------------------------------------"
  cd ..
  sudo docker build -t container .
  echo "------------------------------------------------------------"
}

run_server_docker_image() {
  cd server
  echo "------------------------------------------------------------"
  echo "Running server docker image"
  echo "------------------------------------------------------------"
  sudo docker run -it -p 8080:8080 container
  echo "------------------------------------------------------------"
}

case $1 in
 "setup_client") setup_client;;
 "setup_server") setup_server;;
 "run_client") run_client;;
 "run_server") run_server;;
 "run_client_tests") run_client_tests;;
 "run_server_tests") run_server_tests;;
 "build_server_docker_image") build_server_docker_image;;
 "run_server_docker_image") run_server_docker_image;;
esac

