{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # The default web browser.
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
  };

  imports = [
    ./basic/alacritty.nix
    ./basic/i3.nix
    ./basic/rofi.nix
  ];
}
