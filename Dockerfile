FROM phusion/baseimage:18.04-1.0.0
LABEL maintainer="chris_hubbard@sil.org"
LABEL refreshed_at="2020-12-11"

RUN apt-get update && apt-get install -y\
  ansible\
  python-apt\
  python-pycurl \
  busybox

# Must configure the default inventory file
RUN echo local > /etc/ansible/hosts

COPY ansible /ansible
WORKDIR /ansible

RUN ansible-playbook playbook.yml -c local 

# Clean up when done. (Preserve 'App Projects' directory!)
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/apt/* /tmp/*.* /App \Builder/Scripture\ Apps/App\ Projects/* /tmp/App\ Builder/*
