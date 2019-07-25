{ pkgs, ... }:

{
  xdg.configFile."bat/config".text = ''
    --theme="base16"
  '';
}
