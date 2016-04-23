#!/usr/bin/env bash

SCRIPT_DIR=`dirname $0`

${SCRIPT_DIR}/deployment/deploy.sh

SHA_SHORT=`git rev-parse --short HEAD`

if [ -n "${DOCKER_EMAIL}" ]; then

  echo "==== Setting up docker tags ===="

  echo "tagging container '${SHA_SHORT}_dev' as latest"

  docker tag -f paradoxical/francois:${SHA_SHORT}_dev paradoxical/francois

  if [ -n "$TRAVIS_TAG" ]; then
    echo "tagging container '${SHA_SHORT}_dev' as '${TRAVIS_TAG}'"
    docker tag -f paradoxical/francois:${SHA_SHORT}_dev paradoxical/francois:${TRAVIS_TAG}
  fi

  echo "Logging into docker as ${DOCKER_USERNAME}"

  docker login -e ${DOCKER_EMAIL} -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}

  echo "Logged in!"

  echo "==== Pushing to docker ===="

  echo "pushing container '${SHA_SHORT}_dev'"


  docker push paradoxical/francois:${SHA_SHORT}_dev

  if [ -n "$TRAVIS_TAG" ]; then
    echo "pushing container '${TRAVIS_TAG}'"

    docker push paradoxical/francois:${TRAVIS_TAG}
  fi

  if [ "$TRAVIS_BRANCH" = "master" ]; then
     echo "pushing container as latest"
     docker push paradoxical/francois
  fi
fi
