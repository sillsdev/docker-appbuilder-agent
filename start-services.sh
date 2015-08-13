#!/bin/bash

xvfb-run -a -e /dev/stdout java -jar /opt/swarm-client-jar-with-dependencies.jar "$@"
