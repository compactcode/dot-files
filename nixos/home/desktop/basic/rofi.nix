{ lib, pkgs, ... }:

let theme = import ../../themes/base_16_current.nix;

in {
  programs.rofi = {
    enable = true;

    extraConfig = {
      modi = "drun,calc";
    };

    package = pkgs.rofi.override {
      plugins = [
        pkgs.rofi-calc
      ];
    };

    terminal = "alacritty";
    theme = "Arc-Dark";
  };
}
