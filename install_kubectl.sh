#!/bin/bash

# Reference: https://kubernetes.io/docs/tasks/tools/install-kubectl/

if [[ $EUID -ne 0 ]]; then
  echo "This script should be run using sudo or as the root user"
  exit 1
fi

repo_file="/etc/yum.repos.d/kubernetes.repo"
content="[kubernetes]\nname=Kubernetes\nbaseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg"

if [[ -f ${repo_file} ]]; then
  echo 'found repo file, nothing to do.'
else
  echo -e "create file ${repo_file}"
  touch ${repo_file}
  echo 'add repo content'
  echo -e "${content}" > ${repo_file}
fi

if [[ $(rpm -qa | grep -i -c kubectl) -eq 0 ]]; then
  echo 'install kubectl'
  yum install -y kubectl
else
  echo 'found kubectl, nothing to do'
fi

kubectl version
