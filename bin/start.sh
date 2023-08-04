#!/usr/bin/env bash

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

function findJavaVersion() {
   local ver;
   ver=$(java -version 2>&1 | grep -i version | cut -d'"' -f2 | cut -d'.' -f1-2)
   if [[ ${ver} = "1."* ]]
       then
           ver=$(echo ${ver} | sed -e 's/1\.\([0-9]*\)\(.*\)/\1/; 1q')
       else
           ver=$(echo ${ver} | sed -e 's/\([0-9]*\)\(.*\)/\1/; 1q')
   fi
   echo "${ver}"
}

JAVA_VERSION=$(findJavaVersion)

if [ "${JAVA_VERSION}" -lt 17 ]; then
  echo "AdeptJ Runtime needs Java 17 or newer!"
  exit
fi

RESTEASY_OPTS=" -Dresteasy.allowGzip=true -Dresteasy.role.based.security=true"

JVM_MEM_OPTS="-Xms256m -Xmx512m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=256m"

JVM_OPTS="-server ${JVM_MEM_OPTS}"

if [ "$1" = "jpda" ] ; then
  if [ -z "$JPDA_TRANSPORT" ]; then
    JPDA_TRANSPORT="dt_socket"
  fi
  if [ -z "$JPDA_ADDRESS" ]; then
    JPDA_ADDRESS="localhost:8000"
  fi
  if [ "$2" = "suspend" ] ;
  then
    JPDA_SUSPEND="y"
  else
    JPDA_SUSPEND="n"
  fi
  if [ -z "$JPDA_OPTS" ]; then
    JPDA_OPTS="-agentlib:jdwp=transport=$JPDA_TRANSPORT,address=$JPDA_ADDRESS,server=y,suspend=$JPDA_SUSPEND"
  fi
  JVM_OPTS="$JVM_OPTS $JPDA_OPTS"
  shift
fi

ADEPTJ_RUNTIME_OPTS="${JVM_OPTS} ${RESTEASY_OPTS}
 -Dadeptj.rt.port=8080 \
 -Dadeptj.rt.https.port=8443 \
 -Dadeptj.rt.mode=DEV \
 -Dsmtp.username= \
 -Dsmtp.password= \
 -Denable.http2=false \
 -Dtls.version=TLSv1.3 \
 -Dscan.startup.aware.classes=true \
 -Dwebsocket.logs.tailing.delay=5000 \
 -Dlog.async=true \
 -Dlog.immediate.flush=true \
 -Dlog.purge.files=true \
 -Dfelix.log.level=1 \
 -Dforce.provision.bundles=false \
 -Dshutdown.wait.time=30000 \
 -Dadeptj.session.timeout=3600 \
 -Dmax.concurrent.requests=5000 \
 -Denable.req.buffering=true \
 -Dreq.buff.maxBuffers=200 \
 -Dadeptj.rt.p12-file-external=true \
 -Dadeptj.rt.p12-file-location=/Users/rakesh.kumar/server.p12 \
 -Dadeptj.rt.p12-password=changeit \
 -Denable.eclipselink.exceptionhandler.logging=false \
 -Dorg.jboss.logging.provider=slf4j \
 -Doverwrite.server.conf.file=false \
 -Doverwrite.framework.conf.file=false \
 -Denable.felix.fileinstall=false \
 -Dsearch.osgi.package.exports.provider=true \
 -Dadeptj.rt.log.framework.error=true"

cd target || exit

java ${ADEPTJ_RUNTIME_OPTS} -jar adeptj-runtime-launcher.jar \
-port 8080 \
-shutdownWaitTime 30000 \
-sessionTimeout 3600 \
-maxConcurrentRequests 5000 \
-requestBufferingMaxBuffer 200 \
-felixLogLevel 1 \
-dev \
-scanStartupAwareClasses \
-logAsync \
-logImmediateFlush \
-forceProvisionBundles \
-requestBuffering \
-overwriteServerConf \
-overwriteFrameworkConf \
-logFrameworkError \
-tls TLSv1.3 \
-p12File /Users/rakesh.kumar/server.p12 \
-p12Password changeit
