#!/bin/bash

GREEN=$(echo -en '\033[00;32m')
RESTORE=$(echo -en '\033[0m')

# maven profiles to include support in runtime
CORE_PROFILES='no-shade,JDBC-CP-Hikari,JPA-EclipseLink,Undertow-Server,Aries-SPIFLY,Jetty-HttpClient,'

case "$1" in
  'mariadb')
    MVN_PROFILES="$CORE_PROFILES"'MariaDB'
    ;;
  'mysql')
    MVN_PROFILES="$CORE_PROFILES"'MySQL'
    ;;
  'postgres')
    MVN_PROFILES="$CORE_PROFILES"'PostgreSQL'
    ;;
  *)
    echo -e '\033[31mDB is not specified!\033[0m'
    echo 'Usage: ./jpa.sh mariadb or mysql or postgres'
    exit 1
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