{ pkgs, ... }:

let theme = import ./theme.nix;

in {
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      keybindings = {
        # Default terminal application.
        "Mod1+Return" = "exec --no-startup-id alacritty";

        "Mod1+1" = "workspace 1";
        "Mod1+2" = "workspace 2";
        "Mod1+3" = "workspace 3";

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
          background = theme.darkest;

          focusedWorkspace = {
            background  = theme.darkest;
            text        = theme.light;
            border      = theme.light;
          };
        };
      }];

      colors = {
        focused = {
          background  = theme.dark;
          text        = theme.lightest;

          border      = theme.darker;
          childBorder = theme.darker;
          indicator   = theme.darker;
        };

        unfocused = {
          background  = theme.dark;
          text        = theme.lightest;

          border      = theme.darkest;
          childBorder = theme.darkest;
          indicator   = theme.darkest;
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
    idle_bg     = "${theme.darkest}"
    idle_fg     = "${theme.light}"
    info_bg     = "${theme.info}"
    info_fg     = "${theme.darkest}"
    critical_bg = "${theme.warning}"
    critical_fg = "${theme.darkest}"

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
