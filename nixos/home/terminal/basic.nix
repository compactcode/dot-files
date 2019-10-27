{ pkgs, ... }:

{
  imports = [
    ./basic/bat.nix
    ./basic/fre.nix
    ./basic/htop.nix
    ./basic/neovim.nix
    ./basic/skim.nix
    ./basic/zsh.nix
  ];
}
