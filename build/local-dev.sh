#!/bin/bash

GREEN=$(echo -en '\033[00;32m')
RESTORE=$(echo -en '\033[0m')

# maven profiles to include support in runtime
CORE_PROFILES='no-shade,JDBC-CP-Hikari,JPA-EclipseLink,MyBatis,MySQL,MariaDB,PostgreSQL,MongoDB,Cayenne,OAuth2,Aries-SPIFLY,'

case "$1" in
  'jetty')
    MVN_PROFILES="$CORE_PROFILES"'Jetty-HttpClient-For-Jetty-Server-Adapter,Jetty-Server'
    ;;
  'tomcat')
    MVN_PROFILES="$CORE_PROFILES"'Jetty-HttpClient,Tomcat-Server'
    ;;
  'undertow')
    MVN_PROFILES="$CORE_PROFILES"'Apache-HttpClient,Undertow-Server'
    ;;
  *)
    echo -e '\033[31mServer adapter is not specified, going ahead with Undertow!\033[0m'
    echo 'Usage: ./local-dev.sh jetty or tomcat or undertow'
    MVN_PROFILES="$CORE_PROFILES"'Apache-HttpClient,Undertow-Server'
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