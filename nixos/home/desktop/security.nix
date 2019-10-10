{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnupg
    pass
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableScDaemon = true;
    sshKeys = [
      "D5340EDC116D6C8DFFE80518525712D7E2616FBB"
    ];
  };
}
