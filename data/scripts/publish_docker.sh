#!/bin/bash
# Deploy and run smoketest on doodle
if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters, imagename as arg"
fi
set -e
IMAGE_NAME=$1

VERSION=`grep AppVersion BuildInfo.properties | awk -F'=' '{print $2}'`
TUTUMUSER=`grep -e 'user =' ~/.tutum  | awk '{print $3}'`
docker tag ${IMAGE_NAME}:${VERSION} tutum.co/${TUTUMUSER}/${IMAGE_NAME}:${VERSION} 
docker push tutum.co/${TUTUMUSER}/${IMAGE_NAME}:${VERSION}
