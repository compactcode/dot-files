{ config, pkgs, ... }:

{
  system.stateVersion = "19.03";

  imports =
    [
      ./hardware-configuration.nix
      # Add home-manager module
      "${builtins.fetchGit {
        ref = "release-19.03";
        url = "https://github.com/rycee/home-manager";
      }}/nixos"
    ];

  boot.loader.systemd-boot.enable = true;

  networking.hostName = "shandogs";

  time.timeZone = "Australia/Melbourne";

  environment.systemPackages = with pkgs; [
    git
    ripgrep
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

  users.users.shandogs = {
    isNormalUser = true;
    description = "Shanon McQuay";
    extraGroups = [ "wheel" ];
  }

  home-manager.users.shandogs = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      vimAlias = true;
    };

    programs.zsh = {
      enable = true;
    };

    programs.skim = {
      enable = true;
      enableZshIntegration = true;
    };
  };

}
