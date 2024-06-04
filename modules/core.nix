{pkgs, ...}: {
  boot = {
    loader = {
      # allow displaying boot options
      efi.canTouchEfiVariables = true;

      # use system as the boot manager
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
    };

    # use the latest kernel
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # remove html documentation
  documentation.doc.enable = false;

  environment = {
    systemPackages = with pkgs; [
      dnsutils # dns debugging
      git # version control
      lm_sensors # harware sensors
      nfs-utils # nfs mounting
      pciutils # pci debugging
      usbutils # usb debugging
    ];
  };

  # use english
  i18n.defaultLocale = "en_US.UTF-8";

  # melbourne cbd
  location = {
    latitude = -37.814;
    longitude = 144.96332;
  };

  networking = {
    # enable firewall
    firewall = {
      enable = true;
    };

    # detect and manage network connections
    networkmanager.enable = true;
  };

  # enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs = {
    # nix helper
    nh = {
      enable = true;
      # automatic garbage collection
      clean.enable = true;
      # TODO: find a less hacky way to set this
      flake = "/home/shandogs/Code/personal/dot-files";
    };

    # user shell
    zsh.enable = true;
  };

  # disable hibernation
  systemd.sleep.extraConfig = ''
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  # the timezone to Melbourne
  time.timeZone = "Australia/Melbourne";

  # setup users
  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      root.hashedPassword = "$6$Ol1IgIkZqEqHkDk$X51v4AgMAKXhqpMjfM451dvu71YnMlYdK4lZk/ZFx0m4A/eEPuUfMAYyYwVNjDHMtoNXz6QeoSQg4lHQtHtzX1";

      shandogs = {
        extraGroups = [
          "wheel" # allow sudo
        ];
        isNormalUser = true;
        hashedPassword = "$6$Ol1IgIkZqEqHkDk$X51v4AgMAKXhqpMjfM451dvu71YnMlYdK4lZk/ZFx0m4A/eEPuUfMAYyYwVNjDHMtoNXz6QeoSQg4lHQtHtzX1";
      };
    };
  };
}
