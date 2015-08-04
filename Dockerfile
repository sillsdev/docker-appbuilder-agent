FROM java:7
MAINTAINER <Peter Kohler> "peter_kohler@sil.org"

RUN curl http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/2.0/swarm-client-2.0-jar-with-dependencies.jar > /swarm-client-jar-with-dependencies.jar

ENTRYPOINT ["java","-jar", "/swarm-client-jar-with-dependencies.jar"]
