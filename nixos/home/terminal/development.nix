{ pkgs, ... }:

{
  imports = [
    ./home/direnv.nix
    ./home/git.nix
  ];
}
