{ config, pkgs, ... }:

{
  system.stateVersion = "19.03";

  imports =
    [
      # NOTE: Run `nixos-generate-config` to generate.
      ./hardware-configuration.nix
      # NOTE: Requires git to be installed before `nixos-install` will work.
      "${builtins.fetchGit {
        ref = "release-19.03";
        url = "https://github.com/rycee/home-manager";
      }}/nixos"
    ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = false;
    };
    systemd-boot = {
      enable = true;
    };
  };

  networking.hostName = "nixbox";

  time.timeZone = "Australia/Melbourne";

  environment.systemPackages = with pkgs; [
    bat
    exa
    firefox
    git
    ripgrep
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

  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      root = {
        hashedPassword = "$6$Ol1IgIkZqEqHkDk$X51v4AgMAKXhqpMjfM451dvu71YnMlYdK4lZk/ZFx0m4A/eEPuUfMAYyYwVNjDHMtoNXz6QeoSQg4lHQtHtzX1";
      };
      shandogs = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        hashedPassword = "$6$Ol1IgIkZqEqHkDk$X51v4AgMAKXhqpMjfM451dvu71YnMlYdK4lZk/ZFx0m4A/eEPuUfMAYyYwVNjDHMtoNXz6QeoSQg4lHQtHtzX1";
      };
    };
  };

  home-manager.users.shandogs = { pkgs, ... }: {
    imports = [
      ./home/alacritty.nix
      ./home/git.nix
      ./home/neovim.nix
      ./home/zsh.nix
    ];

    programs.skim = {
      enable = true;
      enableZshIntegration = true;
    };
  };

}
