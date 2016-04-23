#!/usr/bin/env bash

SCRIPT_DIR=`dirname $0`

./deployment/deploy.sh

SHA_SHORT=`git rev-parse --short HEAD`

if [ -n "${DOCKER_EMAIL}" ]; then

  docker tag -f paradoxical/francois:${SHA_SHORT}_dev paradoxical/francois

  if [ -n "$TRAVIS_TAG" ]; then
    docker tag -f paradoxical/francois:${SHA_SHORT}_dev paradoxical/francois:${TRAVIS_TAG}
  fi

  docker login -e ${DOCKER_EMAIL} -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}

  docker push paradoxical/francois:${SHA_SHORT}_dev

  if [ -n "$TRAVIS_TAG" ]; then
    docker push paradoxical/francois:${TRAVIS_TAG}
  fi

  if [ "$TRAVIS_BRANCH" = "master" ]; then
    docker push paradoxical/francois
  fi
fi