#!/bin/sh

set -ex

# Our base channel.
nix-channel --add https://nixos.org/channels/nixos-19.09 nixos

# Include home manager for setting up user environments.
nix-channel --add https://github.com/rycee/home-manager/archive/release-19.09.tar.gz home-manager

# Load the new channels.
nix-channel --update
