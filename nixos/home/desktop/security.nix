{ pkgs, ... }:

{
  home.packages = with pkgs; [
    aws-vault
    gnupg
    pass
  ];
}
