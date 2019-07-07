{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Shanon McQuay";
    userEmail = "shanonmcquay@gmail.com";
    extraConfig = {
      github = {
        username = "compactcode";
      };
    };
  };
}
