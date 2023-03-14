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

  environment = {
    systemPackages = with pkgs; [
      bat # cat replacement
      dnsutils # dns debugging
      du-dust # du replacement
      exa # ls replacement
      fd # find replacement
      fzf # fuzzy finder
      git # version control
      neovim # text editing
      pciutils # pci debugging
      ripgrep # grep replacement
      tailscale # remote access
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
    firewall = {
      enable = true;
      # relax routing for tailscale
      checkReversePath = "loose";
      # allow incoming connections from tailscale
      trustedInterfaces = [ "tailscale0" ];
    };
  };

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services = {
    # remote access
    openssh = {
      enable = true;
      # public key only
      passwordAuthentication = false;
      # public key only
      kbdInteractiveAuthentication = false;
    };

    # remote access
    tailscale.enable = true;
  };

  # the timezone to Melbourne
  time.timeZone = "Australia/Melbourne";

  # setup users
  users = {
    defaultUserShell = pkgs.zsh;

    # A dedicated group for running services
    groups.services = {
      gid = 1001;
    };

    users = {
      root.hashedPassword =
        "$6$Ol1IgIkZqEqHkDk$X51v4AgMAKXhqpMjfM451dvu71YnMlYdK4lZk/ZFx0m4A/eEPuUfMAYyYwVNjDHMtoNXz6QeoSQg4lHQtHtzX1";

      shandogs = {
        extraGroups = [
          "docker" # allow docker control
          "services" # allow service editing
          "wheel" # allow sudo
        ];
        isNormalUser = true;
        hashedPassword =
          "$6$Ol1IgIkZqEqHkDk$X51v4AgMAKXhqpMjfM451dvu71YnMlYdK4lZk/ZFx0m4A/eEPuUfMAYyYwVNjDHMtoNXz6QeoSQg4lHQtHtzX1";
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDP4NxMkmVk7PGDcvi+tJcxRC1UD3T77D2kpdM1S+UmAk/JgjZVHAgiHzdr1wMvOwsfeYoryOZtky68ZOqdAH258n7cCbrfIu9ykdUs2pLia8r59Tl8pmLefhWlGuIXMgWZ+qQI2HJxjqlXq23sZU9UKuifGE4ASD8d/KPFhBPjXCKF7xzjZ0pF+xeo/dFuTuxXpxBaBuNYGGbNjf7EqyfJyiElgQ4S8Q9ZZoI7sPZhmLJgHc2ldjCYWpOqbnvdgA1yO35KbtELiB3VJHmzU/CRY0YrcSr0OmnUUKzVkH10I8mhH4HSo78MpZX/sLHMsnd3DdaNWmO9fjSGFUTvGIlEdIjRev2wKidxvDJ0m5Q/qK79cnwPn03InHX6HuOv1oq/pwNRNPlHdfHrQjUrweMezO/9qV2kCDVWQL92uWavfhhyPmqT6xHAw6kyVvmC5IJVYTnBO+f3HrqhQ6FBZRYls9w60f615DcCic0QuCYttVmfjvnxDZAyP1Y+XJtAdJF+K5dDNox8kzPjLhKnMzx/hvdPewA9zpMXWJW9j5lT5h6anh8/2NjlibzBwR/ClqLeE+3U0lWZx+SOkJvRgmTd4fsrrPByTKiSfHPbx8eUhapKharUz3Zf2c0zCjipmTm6yvgvDeAg491Rc9QsjB45KstYQXYGKq7pjzfHbmo3kQ=="
        ];
      };

      # A dedicated user for running services
      services = {
        isNormalUser = true;
        uid = 1001;
        extraGroups = [
          "services"
        ];
      };
    };
  };

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    storageDriver = "btrfs";
  };
}
