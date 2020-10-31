#!/bin/bash

# Reference: https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html

if [[ $EUID -eq 0 ]]; then
  echo "This script should not be run using sudo or as the root user"
  exit 1
fi

filename="aws-iam-authenticator"
path="${HOME}/bin"
output_file_path="${path}/${filename}"

if [[ -d ${path} ]]; then
  echo -e "${path} exists"
else
  echo -e "create ${path}"
  mkdir ${path}
fi

if [[ -f ${output_file_path} ]]; then
  echo -e "${output_file_path} exists"
else
  echo -e "download ${filename}"
  curl -o ${output_file_path} https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator
  chmod +x ${output_file_path}
fi

${filename}
