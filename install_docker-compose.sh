#!/usr/bin/env bash
# https://docs.docker.com/compose/install/#install-compose
# get docker compose
sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

# add executable
sudo chmod +x /usr/local/bin/docker-compose

# bash completion
# https://docs.docker.com/compose/completion/
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.16.1/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

docker-compose --version

echo "now you can run docker-compose up"
