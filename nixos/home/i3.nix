{ pkgs, config, ... }:

let theme = import ./themes/base_16_nord.nix;

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

        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${config.xdg.configHome}/i3/status.toml";

        fonts = [
          "monospace 10"
        ];

        colors = {
          background = theme.base00;
          separator  = theme.base01;
          statusline = theme.base04;

          focusedWorkspace = {
            background  = theme.base03;
            text        = theme.base0D;
            border      = theme.base03;
          };

          activeWorkspace = {
            background  = theme.base03;
            text        = theme.base0D;
            border      = theme.base03;
          };

          inactiveWorkspace = {
            background  = theme.base01;
            text        = theme.base05;
            border      = theme.base03;
          };

          urgentWorkspace = {
            background  = theme.base08;
            text        = theme.base00;
            border      = theme.base08;
          };

          bindingMode = {
            background  = theme.base0A;
            text        = theme.base00;
            border      = theme.base00;
          };
        };
      }];

      colors = {
        background  = theme.base07;

        focused = {
          border      = theme.base03;
          background  = theme.base0D;
          text        = theme.base00;
          indicator   = theme.base0D;
          childBorder = theme.base03;
        };

        focusedInactive = {
          border      = theme.base01;
          background  = theme.base01;
          text        = theme.base05;
          indicator   = theme.base03;
          childBorder = theme.base01;
        };

        unfocused = {
          border      = theme.base01;
          background  = theme.base00;
          text        = theme.base05;
          indicator   = theme.base01;
          childBorder = theme.base01;
        };

        urgent = {
          border      = theme.base08;
          background  = theme.base08;
          text        = theme.base00;
          indicator   = theme.base08;
          childBorder = theme.base08;
        };

        placeholder = {
          border      = theme.base00;
          background  = theme.base00;
          text        = theme.base05;
          indicator   = theme.base00;
          childBorder = theme.base00;
        };
      };

      window = {
        border = 1;
      };
    };
  };

  xdg.configFile."i3/status.toml".text = ''
    [theme]
    name = "modern"

    [theme.overrides]
    idle_bg     = "${theme.base00}"
    idle_fg     = "${theme.base05}"
    good_bg     = "${theme.base00}"
    good_fg     = "${theme.base05}"
    info_bg     = "${theme.base00}"
    info_fg     = "${theme.base05}"
    warning_bg  = "${theme.base0A}"
    warning_fg  = "${theme.base00}"
    critical_bg = "${theme.base0C}"
    critical_fg = "${theme.base00}"

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
