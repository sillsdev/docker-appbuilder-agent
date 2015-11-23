FROM silintl/ubuntu
MAINTAINER <Peter Kohler> "peter_kohler@sil.org"

RUN apt-get update && apt-get install -y\
  ansible\
  python-apt\
  python-pycurl

RUN curl -o /usr/local/bin/whenavail https://bitbucket.org/silintl/docker-whenavail/raw/master/whenavail 
RUN chmod a+x /usr/local/bin/whenavail

# Must configure the default inventory file
RUN echo local > /etc/ansible/hosts

COPY ansible /ansible
WORKDIR /ansible

RUN ansible-playbook playbook.yml -c local 

COPY start-services.sh /usr/local/bin/start-services.sh

WORKDIR /
ENTRYPOINT ["start-services.sh"]
