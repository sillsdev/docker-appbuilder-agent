FROM silintl/ubuntu:14.04
MAINTAINER <Peter Kohler> "peter_kohler@sil.org"

RUN apt-get update && apt-get install -y\
  ansible\
  python-apt\
  python-pycurl

RUN curl -o /usr/local/bin/whenurlavail https://bitbucket.org/silintl/docker-whenavail/raw/master/whenurlavail 
RUN chmod a+x /usr/local/bin/whenurlavail

# Must configure the default inventory file
RUN echo local > /etc/ansible/hosts

COPY ansible /ansible
WORKDIR /ansible

RUN ansible-playbook playbook.yml -c local 

COPY start-services.sh /usr/local/bin/start-services.sh

WORKDIR /
ENTRYPOINT ["start-services.sh"]
