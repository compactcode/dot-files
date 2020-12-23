{ pkgs, ... }:

{
  imports = [
    ./basic/fre.nix
    ./basic/htop.nix
    ./basic/neovim.nix
    ./basic/skim.nix
    ./basic/zsh.nix
  ];

  programs = {
    bat = {
      enable = true;

      config = {
        theme = "nord";
      };

      themes = {
        nord = (builtins.readFile ../themes/base_16_nord.tmTheme);
      };
    };
  };
}
