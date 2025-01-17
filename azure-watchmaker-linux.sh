#!/bin/sh
yum install -y python3
PYPI_URL=https://pypi.org/simple

# Setup terminal support for UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Install pip
python3 -m ensurepip

# Install setup dependencies
python3 -m pip install --index-url="$PYPI_URL" --upgrade pip setuptools

# Install Watchmaker
python3 -m pip install --index-url="$PYPI_URL" --upgrade watchmaker

# Run Watchmaker
watchmaker --log-level debug --log-dir=/var/log/watchmaker
