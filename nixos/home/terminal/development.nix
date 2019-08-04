{ pkgs, ... }:

{
  imports = [
    ./development/direnv.nix
    ./development/git.nix
  ];
}
