{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnupg
    pass
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };
}
