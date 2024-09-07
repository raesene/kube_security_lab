FROM kindest/node:v1.21.14

RUN apt update && apt install -y python3

COPY ./files/helm /usr/local/bin/