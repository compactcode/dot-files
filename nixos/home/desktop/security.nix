{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    aws-vault
    gnupg
    i3lock-color
    pass
  ];

  services.screen-locker = {
    enable = true;
    lockCmd = "${lib.getBin pkgs.i3lock-color}/bin/i3lock-color -n -c 000000";
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableScDaemon = true;
    sshKeys = [
      "D5340EDC116D6C8DFFE80518525712D7E2616FBB"
    ];
  };
}
