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
    gnome = {
      # packages I don't use
      excludePackages = with pkgs; [
        gnome-console
        gnome-photos
        gnome-text-editor
        gnome-tour
        gnome.cheese
        gnome.epiphany
        gnome.geary # use flatpak instead for sandboxing
        gnome.gedit
        gnome.gnome-clocks
        gnome.gnome-logs
        gnome.gnome-maps
        gnome.gnome-music
        gnome.gnome-weather
        gnome.simple-scan
      ];
    };

    systemPackages = with pkgs; [
      aws-vault # aws credential handling
      bat # cat replacement
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

  # install an nerd font for the icons
  fonts = {
    packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "SourceCodePro" ]; }) ];
  };

  # use english
  i18n.defaultLocale = "en_US.UTF-8";

  # melbourne cbd
  location = {
    latitude = -37.814;
    longitude = 144.96332;
  };

  networking = {
    extraHosts = ''
      127.0.0.1 api.split.test
      127.0.0.1 go.split.test
    '';

    # enable firewall
    firewall = {
      enable = true;
      # relax routing restrictions for tailscale
      checkReversePath = "loose";
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

    # encryption, signing & authentication
    gnupg = {
      agent = {
        enable = true;
        # use yubikey for SHH via gpg
        enableSSHSupport = true;
      };
    };

    # user shell
    zsh.enable = true;
  };

  services = {
    # primary source for graphical applications
    #
    # * discord
    # * geary
    # * obsidian
    # * pinta
    # * signal
    # * slack
    # * steam
    flatpak.enable = true;

    # enable support for yubikey
    pcscd.enable = true;

    # private vpn
    tailscale.enable = true;

    xserver = {
      enable = true;

      # use the gnome desktop
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      # packages I don't use
      excludePackages = with pkgs; [ 
        xterm 
      ];

      # turn caps lock into another ctrl.
      xkbOptions = "ctrl:nocaps";
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
          "docker" # allow docker control
        ];
        isNormalUser = true;
        hashedPassword =
          "$6$Ol1IgIkZqEqHkDk$X51v4AgMAKXhqpMjfM451dvu71YnMlYdK4lZk/ZFx0m4A/eEPuUfMAYyYwVNjDHMtoNXz6QeoSQg4lHQtHtzX1";
      };
    };
  };

  # docker replacement
  virtualisation.docker = {
    enable = true;
    # clean up old images
    autoPrune.enable = true;
  };

  # enable flatpak apps to have system integration (dbus etc)
  xdg.portal.enable = true;
}
