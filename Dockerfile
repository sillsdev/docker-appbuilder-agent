FROM --platform=linux/amd64 phusion/baseimage:jammy-1.0.1
LABEL maintainer="chris_hubbard@sil.org"
LABEL refreshed_at="2024-01-11"

RUN apt-get update && apt-get install -y\
  python3-apt\
  python3-pycurl\
  python3-pip\
  ca-certificates\
  busybox &&\
  python3 -m pip install pip --upgrade pip &&\
  pip install ansible &&\
  apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

COPY ansible /ansible
WORKDIR /ansible

# Clean up when done. (Preserve 'App Projects' directory!)
RUN mkdir -p /etc/ansible && echo local > /etc/ansible/hosts &&\
  ansible-playbook playbook.yml -c local &&\
  apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/apt/* /tmp/*.* /App \Builder/Scripture\ Apps/App\ Projects/* /tmp/App\ Builder/* /root/App\ Builder/Scripture\ Apps/PWA\ Output

#COPY patch /patch
#WORKDIR /patch
#
#RUN patch /root/.rbenv/versions/2.7.1/lib/ruby/gems/2.7.0/gems/fastlane-2.214.0/supply/lib/supply/client.rb < 21507.patch
