#!/bin/bash

GREEN=$(echo -en '\033[00;32m')
RESTORE=$(echo -en '\033[0m')

# maven profiles to include support in runtime
MVN_PROFILES="Copy-Lib,Undertow-Server,Aries-SPIFLY,OAuth2,Jetty-Client-Full"
echo "${GREEN}"
echo -e "######################################################################################"
echo -e "# Building AdeptJ Runtime with following maven profiles                              #"
echo -e "# [$MVN_PROFILES]"
echo -e "# Please select more profiles from pom.xml to add to the build process, if required! #"
echo -e "######################################################################################"
echo "${RESTORE}"

# executing maven with profiles
mvn clean package -P ${MVN_PROFILES}