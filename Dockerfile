FROM silintl/ubuntu
MAINTAINER <Peter Kohler> "peter_kohler@sil.org"

# Add packages.sil.org
RUN echo >> /etc/apt/sources.list "deb http://packages.sil.org/ubuntu trusty main" && \
    echo >> /etc/apt/sources.list "deb http://packages.sil.org/ubuntu trusty-experimental main" && \
    curl http://packages.sil.org/sil.gpg | apt-key add -

# Accept the EULA for android-sdk-installer
RUN dpkg --add-architecture i386
RUN echo android-sdk-installer android-sdk-installer/accepted-android-sdk-eula boolean true | debconf-set-selections -v

RUN apt-get update && apt-get install -y \
  android-sdk-installer \
  curl \
  openjdk-7-jre-headless \
  scripture-app-builder

# Put tools that the build-agent will required here; it will speed up the image build due to Docker's layer caching
RUN apt-get install -y \
  git

RUN curl http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/2.0/swarm-client-2.0-jar-with-dependencies.jar > /opt/swarm-client-jar-with-dependencies.jar

ENTRYPOINT ["java","-jar", "/opt/swarm-client-jar-with-dependencies.jar"]
