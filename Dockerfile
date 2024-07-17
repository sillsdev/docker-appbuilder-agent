FROM ghcr.io/sillsdev/app-builders:latest as builder

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

RUN mkdir -p /app-builders
WORKDIR /app-builders

COPY --from=builder / /app-builders/

#RUN tar -xvf /app-builders.tgz && rm /app-builders.tgz &&\
RUN chmod +x /app-builders/*.sh &&\
  ln -s /app-builders/sab.sh /usr/local/bin/scripture-app-builder &&\
  ln -s /app-builders/rab.sh /usr/local/bin/reading-app-builder &&\
  ln -s /app-builders/dab.sh /usr/local/bin/dictionary-app-builder &&\
  ln -s /app-builders/kab.sh /usr/local/bin/keyboard-app-builder 

COPY ansible /ansible
WORKDIR /ansible

# Clean up when done. (Preserve 'App Projects' directory!)
RUN mkdir -p /etc/ansible && echo local > /etc/ansible/hosts &&\
  ansible-playbook playbook.yml -c local &&\
  apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/apt/* /tmp/*.* /App \Builder/Scripture\ Apps/App\ Projects/* /tmp/App\ Builder/* /root/App\ Builder/Scripture\ Apps/PWA\ Output
#
#COPY patch /patch
#WORKDIR /patch
#
#RUN patch /root/.rbenv/versions/2.7.1/lib/ruby/gems/2.7.0/gems/fastlane-2.214.0/supply/lib/supply/client.rb < 21507.patch
