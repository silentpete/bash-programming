#!/bin/bash
docker ps -qa | xargs docker kill
docker ps -qa | xargs docker rm
