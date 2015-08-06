FROM silintl/ubuntu
MAINTAINER <Peter Kohler> "peter_kohler@sil.org"

# Add packages.sil.org
RUN echo >> /etc/apt/sources.list "deb http://packages.sil.org/ubuntu trusty main" && \
    echo >> /etc/apt/sources.list "deb http://packages.sil.org/ubuntu trusty-experimental main" && \
    curl http://packages.sil.org/sil.gpg | apt-key add -

RUN apt-get update && apt-get install -y \
  curl \
  openjdk-7-jdk \
  scripture-app-builder

RUN dpkg --add-architecture i386
RUN echo android-sdk-installer android-sdk-installer/accepted-android-sdk-eula boolean true | debconf-set-selections -v
RUN apt-get update && apt-get install -y \
  android-sdk-installer

RUN apt-get install -y \
  git

RUN curl http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/2.0/swarm-client-2.0-jar-with-dependencies.jar > /swarm-client-jar-with-dependencies.jar

ENTRYPOINT ["java","-jar", "/swarm-client-jar-with-dependencies.jar"]
