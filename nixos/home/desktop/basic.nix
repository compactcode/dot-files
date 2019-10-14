{ lib, pkgs, ... }:

let
  settings = import ../../settings.nix;
  theme = import ../themes/base_16_current.nix;

in {
  home.packages = with pkgs; [
    libnotify
  ];

  # Ensure config gets propogated to user services.
  xsession = {
    enable = true;
  };

  services = {
    # Add the bluetooth manager to the status bar.
    blueman-applet = {
      enable = true;
    };

    # Display desktop notfications.
    dunst = {
      enable = true;

      settings = {
        global = {
          follow = "keyboard"; # Show notifications where the keyboard has foucs.
          format = "<b>%s</b>\\n%b";
          font = "${settings.font.sansFamily} ${settings.font.defaultSize}";
          frame_width = 2; # Border size.
          geometry = "350x5-18+42"; # Size & location of notifications.
          horizontal_padding = 6;
          markup = "yes"; # Enable basic markup in messages.
          padding = 6; # Vertical padding
          separator_color = "frame"; # Match to the frame color.
          separator_height = 2; # Space between notifications.
          sort = "yes"; # Sort messages by urgency.
        };

        urgency_low = {
          background = theme.base00-hex;
          foreground = theme.base04-hex;
          frame_color = theme.base03-hex;
          timeout = 4;
        };

        urgency_normal = {
          background = theme.base00-hex;
          foreground = theme.base04-hex;
          frame_color = theme.base0A-hex;
          timeout = 6;
        };

        urgency_critical = {
          background = theme.base00-hex;
          foreground = theme.base04-hex;
          frame_color = theme.base0B-hex;
          timeout = 10;
        };
      };
    };

    # Set a background image.
    random-background = {
      enable = true;
      imageDirectory = toString ./art;
    };
  };

  imports = [
    ./basic/alacritty.nix
    ./basic/i3.nix
    ./basic/rofi.nix
  ];
}
