{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;

  networking.hostName = "shandogs";

  time.timeZone = "Australia/Melbourne";

  environment.systemPackages = with pkgs; [
    firefox
    git
    vim
    zsh
  ];

  services.xserver = {
    enable = true;
    desktopManager = {
      default = "xfce";
      xterm = {
        enable = false;
      };
      xfce = {
        enable = true;
      };
    };
  };

  users.defaultUserShell = pkgs.zsh;

  system.stateVersion = "19.03";
}
