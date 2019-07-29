FROM phusion/baseimage:0.11
MAINTAINER <Chris Hubbard> "chris_hubbard@sil.org"

RUN apt-get update && apt-get install -y\
  ansible\
  python-apt\
  python-pycurl

# Must configure the default inventory file
RUN echo local > /etc/ansible/hosts

COPY ansible /ansible
WORKDIR /ansible

RUN ansible-playbook playbook.yml -c local 

# Clean up when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/apt/* /tmp/*.* /App \Builder/* /tmp/App\ Builder/*
