#!/bin/bash

GREEN=$(echo -en '\033[00;32m')
RESTORE=$(echo -en '\033[0m')

# maven profiles to include support in runtime
CORE_PROFILES='Copy-Lib,OAuth2,Aries-SPIFLY,'

case "$1" in
  'jetty')
    MVN_PROFILES="$CORE_PROFILES"'Jetty-Client-Min,Jetty-Server,assemble'
    ;;
  'tomcat')
    MVN_PROFILES="$CORE_PROFILES"'Jetty-Client-Full,Tomcat-Server,assemble'
    ;;
  'undertow')
    MVN_PROFILES="$CORE_PROFILES"'Apache-HttpClient,Undertow-Server,assemble'
    ;;
  *)
    echo -e '\033[31mServer adapter is not specified, going ahead with Jetty!\033[0m'
    echo 'Usage: ./dist-minimal.sh jetty or tomcat or undertow'
    MVN_PROFILES="$CORE_PROFILES"'Jetty-Client-Min,Jetty-Server,assemble'
    ;;
esac

echo "${GREEN}"
echo -e "######################################################################################"
echo -e "# Building AdeptJ Runtime with following maven profiles                              #"
echo -e "# [$MVN_PROFILES]"
echo -e "# Please select more profiles from pom.xml to add to the build process, if required! #"
echo -e "######################################################################################"
echo "${RESTORE}"

# executing maven with profiles
mvn clean package -P ${MVN_PROFILES}