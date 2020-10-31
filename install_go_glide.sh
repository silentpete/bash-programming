#!/bin/bash

echo "Running Glide Installer"

path_adjusted="false"

# REF: https://stackoverflow.com/questions/6569478/detect-if-executable-file-is-on-users-path
executable="go"
path_to_executable=$(which $executable)
if [[ -x "$path_to_executable" ]]; then
  echo "found $executable in PATH:     $path_to_executable"
else
  echo "$executable not found in PATH, exiting."
  exit
fi

if [[ -z ${GOROOT+x} ]]; then
  echo "GOROOT not set, exiting."
  exit
else
  echo "found GOROOT, set to: $GOROOT"
fi

if [[ -z ${GOPATH+x} ]]; then
  echo "GOPATH not set, exiting."
  exit
else
  echo "found GOPATH, set to: $GOPATH"
fi

if [[ -z ${GOBIN+x} ]]; then
  echo 'GOBIN not set'
  echo 'setting GOBIN'
  echo "export GOBIN=${GOROOT}/bin" >> ~/.bashrc
  export GOBIN=${GOROOT}/bin
  echo 'add GOBIN to path'
  echo 'PATH=$PATH:$GOBIN' >> ~/.bashrc
  path_adjusted="true"
else
  echo "found GOBIN, set to:  $GOBIN"
fi

executable="glide"
path_to_executable=$(which $executable)
if [[ -x "$path_to_executable" ]]; then
  echo "found $executable in PATH:  $path_to_executable"
else
  echo "$executable not found, installing."
  curl "https://$executable.sh/get" | sh
fi

if [[ "${path_adjusted}" == "true" ]]; then
  echo 'Please logout and back in to reset your env, or run the following: . ~/.bashrc'
fi

echo "Success, Exiting Glide Installer"
