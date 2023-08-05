#!/bin/bash

###############################################################################
#                                                                             #
#    Copyright 2016, AdeptJ (http://www.adeptj.com)                           #
#                                                                             #
#    Licensed under the Apache License, Version 2.0 (the "License");          #
#    you may not use this file except in compliance with the License.         #
#    You may obtain a copy of the License at                                  #
#                                                                             #
#        http://www.apache.org/licenses/LICENSE-2.0                           #
#                                                                             #
#    Unless required by applicable law or agreed to in writing, software      #
#    distributed under the License is distributed on an "AS IS" BASIS,        #
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. #
#    See the License for the specific language governing permissions and      #
#    limitations under the License.                                           #
#                                                                             #
###############################################################################

# If we are in bin directory then come out of it.
if [ $(basename $(pwd)) = 'bin' ]; then
  cd ..
fi

TARGET_DIR_NAME='target'

function get_launcher_dir() {
  # Check if there is a target directory present.
  local launcher_dir;
  if test -d "$TARGET_DIR_NAME"; then
    launcher_dir="$TARGET_DIR_NAME"
  else
    launcher_dir='.'
  fi
  echo "$launcher_dir"
}

function find_java_version() {
  local ver=$(java -version 2>&1 | grep -i version | cut -d'"' -f2 | cut -d'.' -f1-2)
  if [[ "$ver" = "1."* ]]; then
    ver=$(echo "$ver" | sed -e 's/1\.\([0-9]*\)\(.*\)/\1/; 1q')
  else
    ver=$(echo "$ver" | sed -e 's/\([0-9]*\)\(.*\)/\1/; 1q')
  fi
  echo "$ver"
}

if [ "$(find_java_version)" -lt 17 ]; then
  echo -e '\033[31mCould not start AdeptJ Runtime because it requires Java 17 or newer to run!'
  exit 1
fi

ADEPTJ_RUNTIME_OPTS="-Dadeptj.rt.port=8080 \
                     -Dadeptj.rt.https.port=8443 \
                     -Dadeptj.rt.mode=DEV \
                     -Dtls.version=TLSv1.3 \
                     -Dscan.startup.aware.classes=true \
                     -Dlog.async=true \
                     -Dlog.immediate.flush=true \
                     -Dlog.purge.files=true \
                     -Dfelix.log.level=1 \
                     -Dforce.provision.bundles=false \
                     -Denable.eclipselink.exceptionhandler.logging=false \
                     -Dorg.jboss.logging.provider=slf4j \
                     -Doverwrite.server.conf.file=false \
                     -Doverwrite.framework.conf.file=false \
                     -Denable.felix.fileinstall=false \
                     -Dsearch.osgi.package.exports.provider=true \
                     -Dadeptj.rt.log.framework.error=true \
                     -Dresteasy.allowGzip=true \
                     -Dresteasy.role.based.security=true"

JVM_MEM_OPTS="-Xms256m -Xmx512m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=256m"

JVM_OPTS="-server ${JVM_MEM_OPTS}"

if [ "$1" = 'jpda' ] ; then
  if [ -z "$JPDA_TRANSPORT" ]; then
    JPDA_TRANSPORT='dt_socket'
  fi
  if [ -z "$JPDA_ADDRESS" ]; then
    JPDA_ADDRESS='localhost:8000'
  fi
  if [ "$2" = 'suspend' ]; then
    JPDA_SUSPEND='y'
  else
    JPDA_SUSPEND='n'
  fi
  if [ -z "$JPDA_OPTS" ]; then
    JPDA_OPTS="-agentlib:jdwp=transport=$JPDA_TRANSPORT,address=$JPDA_ADDRESS,server=y,suspend=$JPDA_SUSPEND"
  fi
  JVM_OPTS="$JVM_OPTS $JPDA_OPTS"
  shift
fi

if [ "$(get_launcher_dir)" = "$TARGET_DIR_NAME" ]; then
  cd target
fi

#Note: append "& echo $! > adeptj.pid" in the end to run the process in background.

java ${JVM_OPTS} ${ADEPTJ_RUNTIME_OPTS} -jar adeptj-runtime-launcher.jar