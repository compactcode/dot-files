{ pkgs, ... }:

{
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
      aws-vault # aws credential handling
      bat # cat replacement
      devbox # development environments
      dnsutils # dns debugging
      du-dust # du replacement
      eza # ls replacement
      fd # find replacement
      fzf # fuzzy finder
      git # version control
      jq # json formatting
      lm_sensors # harware sensors
      lnav # log viewing
      nfs-utils # nfs mounting
      pciutils # pci debugging
      ripgrep # grep replacement
      tailscale # private vpn
      usbutils # usb debugging
      wl-clipboard # clipboard interaction
      xsv # csv viewer
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
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs = {
    # password manager
    _1password.enable = true;

    # password manager gui, installed here over flatpak for access to the kernel keyring
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "shandogs" ];
    };

    # web browser, installed here over flatpak for access to the kernel keyring
    firefox.enable = true;

    # window manager
    hyprland.enable = true;

    # user shell
    zsh.enable = true;
  };

  # enable real-time scheduling for pipewire
  security.rtkit.enable = true;

  services = {
    # primary source for graphical applications
    flatpak.enable = true;

    # enable sound via pipewire
    pipewire = {
      enable = true;
      # pulseaudio compatibility
      pulse.enable = true;
    };
  };

  # the timezone to Melbourne
  time.timeZone = "Australia/Melbourne";

  # setup users
  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      root.hashedPassword =
        "$6$Ol1IgIkZqEqHkDk$X51v4AgMAKXhqpMjfM451dvu71YnMlYdK4lZk/ZFx0m4A/eEPuUfMAYyYwVNjDHMtoNXz6QeoSQg4lHQtHtzX1";

      shandogs = {
        extraGroups = [
          "wheel" # allow sudo
        ];
        isNormalUser = true;
        hashedPassword =
          "$6$Ol1IgIkZqEqHkDk$X51v4AgMAKXhqpMjfM451dvu71YnMlYdK4lZk/ZFx0m4A/eEPuUfMAYyYwVNjDHMtoNXz6QeoSQg4lHQtHtzX1";
      };
    };
  };
}
