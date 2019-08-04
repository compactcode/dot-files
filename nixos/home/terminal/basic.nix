{ pkgs, ... }:

{
  imports = [
    ../bat.nix
    ../fre.nix
    ../neovim.nix
    ../skim.nix
    ../zsh.nix
  ];
}
