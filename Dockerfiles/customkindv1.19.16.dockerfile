FROM kindest/node:v1.19.16

RUN apt update && apt install -y python3

COPY ./files/helm /usr/local/bin/