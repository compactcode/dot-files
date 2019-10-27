{ lib, pkgs, ... }:

{
  programs.skim = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "${lib.getBin pkgs.fd}/bin/fd --type f";
    defaultOptions = [
      "--reverse"
      "--height 40%"
    ];
  };
}
