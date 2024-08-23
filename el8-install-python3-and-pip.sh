#!/bin/bash

echo "dnf install python39, then set alternatives "
dnf install -y python39 python3-pip
alternatives --set python /usr/bin/python3.9
alternatives --set python3 /usr/bin/python3.9
echo "done installing python39 and setting alternatives"

echo "use python3 module pip to install and upgrade pip "
python3 -m pip install --upgrade pip
echo "done updating pip"
