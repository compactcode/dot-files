{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;

    terminal = "${pkgs.dash}/bin/dash";

    theme = "Arc-Dark";
  };
}
