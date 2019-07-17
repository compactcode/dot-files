{ pkgs, ... }:

{
  programs.skim = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f";
    defaultOptions = [
      "--reverse"
      "--height 40%"
    ];
  };
}
