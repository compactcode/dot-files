{ lib, pkgs, ... }:

let
  launcher = "${lib.getBin pkgs.i3}/bin/i3-msg exec";

in {
  home.packages = with pkgs; [
    firefox
  ];

  # Ensure config gets propogated to user services.
  xsession = {
    enable = true;
  };

  services = {
    random-background = {
      enable = true;
      imageDirectory = toString ./art;
    };

    screen-locker = {
      enable = true;
      lockCmd = "${launcher} '${lib.getBin pkgs.lightdm}/bin/dm-tool lock'";
    };
  };

  imports = [
    ./basic/alacritty.nix
    ./basic/i3.nix
    ./basic/rofi.nix
  ];
}
