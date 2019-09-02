#!/bin/sh

set -ex

# Our base channel.
nix-channel --add https://nixos.org/channels/nixos-19.03 nixos

# Include the unstable channel so we can upgrade specific packages.
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable

# Include home manager for setting up user environments.
nix-channel --add https://github.com/rycee/home-manager/archive/release-19.03.tar.gz home-manager

# Load the new channels.
nix-channel --update
