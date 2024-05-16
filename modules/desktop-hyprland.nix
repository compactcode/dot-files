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
      du-dust # du replacement
      git # version control
      lm_sensors # harware sensors
      nfs-utils # nfs mounting
      pciutils # pci debugging
      tailscale # mesh vpn
      usbutils # usb debugging
      wl-clipboard # clipboard interaction
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
    # password manager
    _1password.enable = true;

    # password manager gui, installed here over flatpak for access to the kernel keyring
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["shandogs"];
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

    # login manager
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "Hyprland";
          user = "shandogs";
        };
        # skip first login since boot requires luks password
        default_session = initial_session;
      };
    };

    # enable sound via pipewire
    pipewire = {
      enable = true;
      # pulseaudio compatibility
      pulse.enable = true;
    };
  };

  systemd = {
    user.services = {
      # start 1password so applications can make requests
      _1password = {
        description = "1password";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs._1password-gui}/bin/1password --silent";
        };
      };

      # start authentication agent to applications can make requests
      polkit-authentication-agent = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  };

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
