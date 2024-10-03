{...}: {
  programs = {
    # status bar
    waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top"; # display on top of other windows
          spacing = 5;

          modules-left = [
            "hyprland/workspaces" # active workspaces
            "hyprland/submap" # active keybind mode
          ];
          modules-center = [
            "clock"
          ];
          modules-right = [
            "temperature"
            "network"
            "pulseaudio" # sound
            "battery"
            "tray" # system tray
          ];

          battery = {
            interval = 60;
            states = {
              warning = 30;
              critical = 1;
            };
            "format" = "{capacity}% {icon}";
            "format-icons" = ["" "" "" "" ""];
          };

          clock = {
            format = "{:%H.%M}";
            tooltip = true;
            tooltip-format = "{:%d.%m.%Y}";
          };

          network = {
            format = "{bandwidthUpBytes} {bandwidthDownBytes} 󰈀";
            interval = 10;
          };

          pulseaudio = {
            format = "{volume}% {icon} {format_source}";
            format-muted = "󰝟 {format_source}";
            format-icons = {
              headphone = "󰋋";
              muted-icon = "󰝟";
              default = ["󰕿" "󰖀" "󰕾"];
            };
            format-source = "{volume}% 󰍬";
            format-source-muted = " 󰍭";
            on-click = "pavucontrol";
            scroll-step = 5;
          };

          temperature = {
            format = "{temperatureC}°C 󰻠";
          };

          tray = {
            spacing = 5;
          };
        };
      };

      systemd.enable = true;
    };
  };

  # automatic styling
  stylix = {
    targets = {
      waybar.enable = true;
    };
  };
}
