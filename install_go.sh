#!/bin/bash

# VERBOSE
# Running with VERBOSE will add addition output you may want for debugging or extra verbage.

# debug_msg: pass in arguments and they will all print in green.
function debug_msg () {
  echo -e "\e[36mtime=\"$(date --rfc-3339='seconds')\" level=DEBUG msg=\"$@\"\e[0m"
}

# info_msg: pass in arguments and they will all print in green.
function info_msg () {
  echo -e "\e[32mtime=\"$(date --rfc-3339='seconds')\" level=INFO msg=\"$@\"\e[0m"
}

# warn_msg: pass in arguments and they will all print in yellow.
function warn_msg () {
  echo -e "\e[33mtime=\"$(date --rfc-3339='seconds')\" level=WARN msg=\"$@\"\e[0m"
}

# error_msg: pass in arguments and they will all print in red, then the script will exit 1.
function error_msg () {
  echo -e "\e[31mtime=\"$(date --rfc-3339='seconds')\" level=ERROR msg=\"$@\"\e[0m"
  exit 1
}

default_gopath="$HOME/gocode"
default_gotmpdir="$HOME/gotmpdir"
goVersion="1.13.5"
goDir="go${goVersion}"

# Set working directory
[[ $VERBOSE ]] && debug_msg 'moving to home directory'
cd
CWD="${HOME}"

if [[ -d ${default_gopath} ]]; then
  [[ $VERBOSE ]] && debug_msg "found \"${default_gopath}\""
else
  info_msg "Setup my Go coding directory"
  [[ $VERBOSE ]] && debug_msg "did not find directory: \"${default_gopath}\", making directory"
  mkdir "${default_gopath}"
  mkdir "${default_gopath}/bin"
  mkdir "${default_gopath}/pkg"
  mkdir "${default_gopath}/src"
  mkdir "${default_gopath}/src/github.com"
  mkdir "${default_gopath}/src/github.com/silentpete"
fi

if [[ -d ${goDir} ]]; then
  [[ $VERBOSE ]] && debug_msg "found \"${HOME}/${goDir}\""
else
  info_msg "Create ~/go<ver> directory"
  [[ $VERBOSE ]] && debug_msg "did not find directory: \"${HOME}/${goDir}\", making directory"
  mkdir "${goDir}"

  info_msg "Set Go directory full path:"
  goInstallPath="${CWD}/${goDir}"
  info_msg "${goInstallPath}"

  info_msg "downloading Go ${goVersion} tar.gz"
  curl --insecure --progress-bar "https://dl.google.com/go/${goDir}.linux-amd64.tar.gz" | tar -xz --directory "${goInstallPath}" --strip-components=1
fi

path_adjusted="false"
# TODO: add better checking
if [[ -z ${GOROOT+x} ]]; then
  info_msg "Set GOROOT"
  [[ $VERBOSE ]] && debug_msg 'GOROOT not set, setting GOROOT'
  echo "export GOROOT=\$HOME/${goDir}" >> ~/.bashrc
  [[ $VERBOSE ]] && debug_msg 'add GOROOT to path'
  echo 'export PATH=$PATH:$GOROOT/bin' >> ~/.bashrc
  path_adjusted="true"
else
  [[ $VERBOSE ]] && debug_msg 'variable GOROOT already set'
fi

if [[ -z ${GOPATH+x} ]]; then
  info_msg "Set GOPATH"
  [[ $VERBOSE ]] && debug_msg 'GOPATH not set, setting GOPATH'
  echo "export GOPATH=${default_gopath}" >> ~/.bashrc
  [[ $VERBOSE ]] && debug_msg 'add GOPATH to path'
  echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
  path_adjusted="true"
else
  [[ $VERBOSE ]] && debug_msg 'variable GOPATH already set'
fi

# setup the GOTMPDIR
if [[ -d ${default_gotmpdir} ]]; then
  [[ $VERBOSE ]] && debug_msg "found \"${default_gotmpdir}\""
else
  info_msg "Create GOTMPDIR directory"
  [[ $VERBOSE ]] && debug_msg "did not find directory: \"${default_gotmpdir}\", making directory"
  mkdir "${default_gotmpdir}"
fi

if [[ -z ${GOTMPDIR+x} ]]; then
  info_msg "Set GOTMPDIR"
  [[ $VERBOSE ]] && debug_msg 'GOTMPDIR not set, setting GOTMPDIR'
  echo "export GOTMPDIR=${default_gotmpdir}" >> ~/.bashrc
else
  [[ $VERBOSE ]] && debug_msg 'variable GOTMPDIR already set'
fi

if [[ "${path_adjusted}" == "true" ]]; then
  info_msg 'Please logout and back in to reset your env, or run the following: . ~/.bashrc'
fi

# check if go exist should produce...
# $ which go
# ~/go{ver}/bin/go
