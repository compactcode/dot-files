{ config, pkgs, ... }:

{
  system.stateVersion = "19.03";

  imports =
    [
      # NOTE: Run `nixos-generate-config` to generate.
      /etc/nixos/hardware-configuration.nix
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
    dash
    firefox
    fzy
    git
    ripgrep
    zsh
  ];

  fonts.fonts = [
    # Use v4 until i3status-rust is updated.
    pkgs.font-awesome_4
  ];

  services.xserver = {
    enable = true;

    desktopManager = {
      default = "none";
      xterm = {
        enable = false;
      };
    };

    windowManager = {
      i3 = {
        enable = true;

        package = pkgs.i3-gaps;

        extraPackages = with pkgs; [
          i3status-rust
        ];
      };
    };
  };

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
      ./home/i3.nix
      ./home/neovim.nix
      ./home/rofi.nix
      ./home/skim.nix
      ./home/zsh.nix
    ];
  };

}
