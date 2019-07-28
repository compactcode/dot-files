{ pkgs, ... }:

{
  xdg.configFile."bat/config".text = ''
    --theme="nord"
  '';

  xdg.configFile."bat/themes/nord.tmTheme".source = ../themes/base_16_nord.tmTheme;
}
