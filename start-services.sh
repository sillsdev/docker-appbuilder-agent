#!/bin/bash

# There is a timing issue in the swarm-client.  The startup
# for the jenkins is now faster and the appbuilder-agent
# tends to get stuck starting up.  By waiting until
# JENKINS_URL/plugin/swarm/slaveInfo is available allows
# for clean startup.
# This is needed in production as well.  It is OK to have
# this startup dependency with AWS ECS since Jenkins 
# master and slave are one task definition.  If these are
# split up into separate task definitions, then a correct
# fix of swarm-client will need to be implemented.
for i in `seq 1 $#`;
do
opt=${@:$i:1}
case $opt in
	-master)
	URL=${@:$i+1:1}
	;;
esac
done

if [ -n "$URL" ]; then
whenurlavail "${URL}/plugin/swarm/slaveInfo" 10 0 java -jar /opt/swarm-client-jar-with-dependencies.jar "$@"
else
java -jar /opt/swarm-client-jar-with-dependencies.jar "$@"
fi
