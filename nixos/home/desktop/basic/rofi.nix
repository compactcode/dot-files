{ lib, pkgs, ... }:

let theme = import ../../themes/base_16_current.nix;

in {
  # Launch a duckduckgo search.
  xdg.dataFile."bin/duckduckgo" = {
    executable = true;
    text = ''
      #!/bin/sh

      rofi -dmenu -lines 0 -p duckduckgo | xargs -I{} firefox 'https://duckduckgo.com/?q={}'
    '';
  };

  programs.rofi = {
    enable = true;

    extraConfig = {
      modi = "drun,calc";
    };

    colors = {
      window = {
        background = theme.base00-hex;
        border = theme.base05-hex;
        separator = theme.base05-hex;
      };

      rows = {
        normal = {
          background = theme.base00-hex;
          foreground = theme.base05-hex;
          backgroundAlt = theme.base03-hex;
          highlight = {
            background = theme.base00-hex;
            foreground = theme.base0A-hex;
          };
        };
      };
    };

    package = pkgs.rofi.override {
      plugins = [
        pkgs.rofi-calc
      ];
    };

    terminal = "alacritty";
  };
}
