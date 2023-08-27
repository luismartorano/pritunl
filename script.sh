#!/bin/bash
tee /etc/yum.repos.d/pritunl.repo << EOF
[pritunl]
name=Pritunl 
baseurl=https://repo.pritunl.com/stable/yum/amazonlinux/2/
gpgcheck=1
enabled=1
EOF
sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A
gpg --armor --export 7568D9BB55FF9E5287D586017AE645C0CF8E292A > key.tmp; rpm --import key.tmp; rm -f key.tmp
sudo yum -y update
sudo yum -y install pritunl-link

sudo pritunl-link verify-off
sudo pritunl-link provider aws
sudo pritunl-link add pritunl://token:secret@test.pritunl.com
