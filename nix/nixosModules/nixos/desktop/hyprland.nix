{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    # window manager
    hyprland = {
      enable = true;
      # use systemd
      withUWSM = true;
    };
  };

  # allow swaylock to perform authentication
  security.pam.services.swaylock = {};

  services = {
    # login manager
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop";
          user = "shandogs";
        };
        # skip first login since boot requires luks password
        default_session = initial_session;
      };
    };
  };

  systemd = {
    # dont block boot waiting for networking
    services.NetworkManager-wait-online.enable = false;
  };

  xdg = {
    # allow applications to request system resources
    portal = {
      enable = true;

      config = {
        common = {
          default = [
            "hyprland"
            "gtk" # file picker fallback
          ];
        };
      };

      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
