#!/bin/sh

set -ex

# Our base channel.
sudo -i nix-channel --add https://nixos.org/channels/nixos-20.09 nixos

# Include home manager for setting up user environments.
sudo -i nix-channel --add https://github.com/rycee/home-manager/archive/release-20.09.tar.gz home-manager

# Load the new channels.
sudo -i nix-channel --update
