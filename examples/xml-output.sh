#!/bin/bash

#firewalld, creating a service file

service="${serviceName,,}"
port="8080"

contents="<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<service>\n  <short>${service}</short>\n  <description>${service}</description>\n  <port protocol=\"tcp\" port=\"${port}\"/>\n</service>"

echo -e "${contents}"
