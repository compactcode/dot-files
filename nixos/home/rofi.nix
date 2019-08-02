{ pkgs, ... }:

let theme = import ./themes/base_16_current.nix;

in {
  programs.rofi = {
    enable = true;

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
  };
}
