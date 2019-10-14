{ lib, pkgs, ... }:

let
  launcher = "${lib.getBin pkgs.i3}/bin/i3-msg exec";

in {
  # Ensure config gets propogated to user services.
  xsession = {
    enable = true;
  };

  services = {
    # Add the bluetooth manager to the status bar.
    blueman-applet = {
      enable = true;
    };

    # Display desktop notfications.
    dunst = {
      enable = true;
    };

    # Set a background image.
    random-background = {
      enable = true;
      imageDirectory = toString ./art;
    };
  };

  imports = [
    ./basic/alacritty.nix
    ./basic/i3.nix
    ./basic/rofi.nix
  ];
}
