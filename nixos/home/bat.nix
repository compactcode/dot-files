{ pkgs, ... }:

{
  xdg.configFile."bat/config".text = ''
    --theme="OneHalfDark"
  '';
}
