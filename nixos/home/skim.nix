{ pkgs, ... }:

{
  programs.skim = {
    enable = true;
    enableZshIntegration = true;
  };
}
