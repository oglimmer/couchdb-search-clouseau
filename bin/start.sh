#!/bin/bash

set -eu

if [ "${1:-}" = "start" ]; then

echo "${JAVA_XMX:--Xmx1G}"

java -cp '/opt/clouseau/lib/*' \
     -server \
     ${JAVA_XMX:--Xmx1G} \
     -Dsun.net.inetaddr.ttl=30 \
     -Dsun.net.inetaddr.negative.ttl=30 \
     -Dlog4j.configuration=file:/opt/clouseau/etc/log4j.properties \
     -XX:OnOutOfMemoryError="kill -9 %p" \
     -XX:+UseConcMarkSweepGC \
     -XX:+CMSParallelRemarkEnabled \
     com.cloudant.clouseau.Main \
     /opt/clouseau/etc/clouseau.ini

else
	eval $@
fi
