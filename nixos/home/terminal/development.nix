{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Secure AWS credential handling.
    aws-vault
  ];

  imports = [
    ./development/direnv.nix
    ./development/git.nix
  ];
}
