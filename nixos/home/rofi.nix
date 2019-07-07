{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;

    terminal = "${pkgs.dash}/bin/dash";
  };
}
