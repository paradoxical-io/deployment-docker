#!/usr/bin/env bash


SCRIPT_DIR=`dirname $0`

./deployment/setup-travis.sh

if [ -z "${DOCKER_EMAIL}" ]; then
    read -p "DOCKER_EMAIL=" DOCKER_EMAIL
fi

if [ -z "${DOCKER_USERNAME}" ]; then
    read -p "DOCKER_USERNAME=" DOCKER_USERNAME
fi

if [ -z "${DOCKER_PASSWORD}" ]; then
    read -p "DOCKER_PASSWORD=" DOCKER_PASSWORD
fi

travis encrypt "DOCKER_EMAIL='${DOCKER_EMAIL}'" -a
travis encrypt "DOCKER_USERNAME='${DOCKER_USERNAME}'" -a
travis encrypt "DOCKER_PASSWORD='${DOCKER_PASSWORD}'" -a
