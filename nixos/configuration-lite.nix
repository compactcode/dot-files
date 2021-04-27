{ lib, pkgs, ... }:

let
  settings = import ./settings.nix;

in {
  system.stateVersion = "20.09";

  time.timeZone = "Australia/Melbourne";

  location = {
    latitude = -37.814;
    longitude = 144.96332;
  };

  networking = {
    # Enable firewall.
    firewall = {
      enable = true;
    };

    # Detect and manage network connections.
    networkmanager = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Command line utilities.
    exfat # mount exfat drives.
    ethtool # ethernet debugging.
    glxinfo # gfx debugging.
    lm_sensors # system sensor access.
    nfs-utils # mount nfs drives.
    pciutils # pci debugging.
    usbutils # usb debugging.
  ];

  services = {
    # Enable support for gpg smart cards.
    pcscd = {
      enable = true;
    };

    xserver = {
      enable = true;

      desktopManager = {
        gnome3.enable = true;
      };

      # Turn caps lock into another ctrl.
      xkbOptions = "ctrl:nocaps";
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      root = {
        hashedPassword = settings.user.hashedPassword;
      };

      ${settings.user.username} = {
        isNormalUser = true;
        extraGroups = [
          "wheel" # Enable sudo.
        ];
        hashedPassword = settings.user.hashedPassword;
      };
    };
  };
}
