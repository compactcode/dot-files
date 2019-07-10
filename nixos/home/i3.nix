{ pkgs, ... }:

let colors = import ./colors.nix;

in {
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      keybindings = {
        # Default terminal application.
        "Mod1+Return" = "exec alacritty";

        # Default launcher.
        "Mod1+d" = "exec rofi -show run -lines 10";

        "Mod1+h" = "focus left";
        "Mod1+j" = "focus down";
        "Mod1+k" = "focus up";
        "Mod1+l" = "focus right";

        # Fullscreen current window.
        "Mod1+f" = "fullscreen toggle";

        # Kill current window.
        "Mod1+w" = "kill";
      };

      gaps = {
        inner = 12;
        outer = 6;
      };

      bars = [{
        position = "top";
        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3/status.toml";
        fonts = [
          "monospace 10"
        ];
        colors = {
          background = colors.background;
        };
      }];

      colors = {
        focused = {
          border      = colors.border;
          childBorder = colors.border;
          background  = colors.background;
          text        = colors.foreground;
          indicator   = colors.critical_background;
        };
      };

      window = {
        border = 2;
      };
    };
  };

  home.file.".config/i3/status.toml".text = ''
    [theme]
    name = "modern"

    [theme.overrides]
    idle_bg     = "${colors.background}"
    idle_fg     = "${colors.foreground}"
    info_bg     = "${colors.info_background}"
    info_fg     = "${colors.info_foreground}"
    critical_bg = "${colors.critical_background}"
    critical_fg = "${colors.critical_foreground}"

    [icons]
    name = "awesome"

    [[block]]
    block = "disk_space"
    path = "/"
    alias = "/"
    info_type = "available"
    unit = "GB"
    interval = 20
    warning = 20.0
    alert = 10.0

    [[block]]
    block = "memory"
    display_type = "memory"
    format_mem = "{Mup}%"
    format_swap = "{SUp}%"

    [[block]]
    block = "cpu"
    interval = 1

    [[block]]
    block = "load"
    interval = 1
    format = "{1m}"

    [[block]]
    block = "time"
    interval = 60
    format = "%a %l:%M %p"
  '';
}
