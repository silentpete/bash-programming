#!/bin/bash
# https://docs.docker.com/engine/installation/linux/docker-ce/centos/#install-using-the-convenience-script

# TODO: check if run as sudo/root

# TODO: if docker found, remove before proceeding
#sudo yum remove docker docker-common docker-selinux docker-engine

sudo yum install -y yum-utils device-mapper-persistent-data lvm2

sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y docker-ce docker-ce-cli containerd.io

sudo systemctl enable docker

sudo systemctl start docker
