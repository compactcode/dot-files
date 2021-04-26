#!/bin/sh

set -ex

# Our base channel.
sudo -i nix-channel --add https://nixos.org/channels/nixos-unstable nixos

# Include home manager for setting up user environments.
sudo -i nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

# Load the new channels.
sudo -i nix-channel --update
