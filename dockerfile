# base image
FROM openkbs/jdk11-mvn-py3:latest

# Running the terminal command to update the apt and any pop up will be answer with a y
RUN sudo -s
RUN sudo apt-get update


# Running the terminal command to install  sqlite3 and any pop up will be answer with a y
RUN sudo apt install sqlite3 -y

# Running the terminal command to update the apt and any pop up will be answer with a y
RUN sudo apt update

# Running the terminal command to install sqlitebrowser and any pop up will be answer with a y
RUN sudo apt-get install sqlitebrowser -y

# Copying all files from current dictory to the image in the current dictory
COPY . .

WORKDIR server

RUN mvn initialize
RUN mvn -B  dependency:resolve-plugins dependency:resolve
RUN sudo chmod ugo+rwx database
RUN sudo chmod ugo+rwx database/test_db.sqlite
RUN sudo chmod ugo+rwx database/user_db.sqlite

#Opens the 8080 port.
EXPOSE 8080

ENTRYPOINT ["java","-jar","target/server-1.0-SNAPSHOT-jar-with-dependencies.jar"]
