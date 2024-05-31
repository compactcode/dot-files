{pkgs, ...}: {
  programs = {
    # window manager
    hyprland.enable = true;
  };

  services = {
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
  };

  # automatic theming
  stylix = {
    opacity = {
      applications = 0.9;
      terminal = 0.9;
    };
  };

  systemd = {
    # dont block boot waiting for networking
    services.NetworkManager-wait-online.enable = false;

    user.services = {
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
