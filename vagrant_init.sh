#!/bin/bash

# Only run this after standing up a new vagrant environment.

echo 'copying in my bashrc stuff'
cat /dropbox-code/github.com/silentpete/cm/random_files/.bashrc >> ~/.bashrc

echo 'install Go'
/dropbox-code/github.com/silentpete/cm/sh_scripts/install_go.sh

echo 'run yum updates'
sudo yum -y update
