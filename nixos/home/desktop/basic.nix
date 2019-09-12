{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # The default web browser.
    firefox
  ];

  imports = [
    ./basic/alacritty.nix
    ./basic/i3.nix
    ./basic/rofi.nix
  ];

  # The image that will be set as a background image.
  home.file.".background-image".source = pkgs.copyPathToStore ../../art/wallpaper-coffee-3840x2560.jpg;
}
