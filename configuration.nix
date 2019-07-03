{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./vim.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nixos";
  time.timeZone = "Australia/Melbourne";

  environment.systemPackages = with pkgs; [
    firefox
    ripgrep
    git
    fasd
    zsh
    zsh-prezto
    (import ./vim.nix)
  ];

  programs.zsh = {
    enable = true;
    promptInit = "";
    interactiveShellInit = ''
      zstyle ':prezto:load' pmodule \
        'environment' \
        'editor' \
        'fasd' \
        'directory' \
        'history' \
        'prompt'

      zstyle ':prezto:module:prompt' theme 'pure'

      source ${pkgs.zsh-prezto}/init.zsh
    '';
  };

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
  users.users.shandogs = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "19.03";
}
