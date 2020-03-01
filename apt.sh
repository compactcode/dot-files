#!/bin/bash

set -ex

sudo apt-get update

sudo apt-get install -y build-essential
# TODO: Move to snap.
sudo apt-get install -y chromium-browser
sudo apt-get install -y chromium-chromedriver
sudo apt-get install -y curl
# TODO: Move to snap.
sudo apt-get install -y firefox
sudo apt-get install -y git
sudo apt-get install -y postgresql-10
sudo apt-get install -y postgresql-server-dev-10
sudo apt-get install -y redis-server
sudo apt-get install -y snapd
sudo apt-get install -y zsh
