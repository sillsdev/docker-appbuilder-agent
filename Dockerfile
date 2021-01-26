FROM phusion/baseimage:18.04-1.0.0
LABEL maintainer="chris_hubbard@sil.org"
LABEL refreshed_at="2020-12-11"

RUN apt-get update && apt-get install -y\
  python3-apt\
  python3-pycurl\
  python3-pip\
  busybox
RUN python3 -m pip install pip --upgrade pip
RUN pip install ansible

# Must configure the default inventory file
RUN mkdir -p /etc/ansible && echo local > /etc/ansible/hosts

COPY ansible /ansible
WORKDIR /ansible

RUN ansible-playbook playbook.yml -c local 

# Clean up when done. (Preserve 'App Projects' directory!)
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/apt/* /tmp/*.* /App \Builder/Scripture\ Apps/App\ Projects/* /tmp/App\ Builder/*
