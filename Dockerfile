FROM silintl/ubuntu
MAINTAINER <Peter Kohler> "peter_kohler@sil.org"

RUN apt-get update && apt-get install -y\
  ansible\
  python-apt\
  python-pycurl

# Must configure the default inventory file
RUN echo local > /etc/ansible/hosts

COPY ansible /ansible
WORKDIR /ansible

RUN ansible-playbook playbook.yml -c local 

WORKDIR /
ENTRYPOINT ["xvfb-run","-e", "/dev/stdout", "java","-jar", "/opt/swarm-client-jar-with-dependencies.jar"]
