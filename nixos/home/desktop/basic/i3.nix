{ pkgs, config, ... }:

let theme = import ../../themes/base_16_current.nix;

in {
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      keybindings = {
        # Default terminal application.
        "Mod1+Return" = "exec --no-startup-id alacritty";

        # Switch to workspace.
        "Mod1+1" = "workspace 1";
        "Mod1+2" = "workspace 2";
        "Mod1+3" = "workspace 3";
        "Mod1+4" = "workspace 4";
        "Mod1+5" = "workspace 5";

        # Move applications to another workspace.
        "Mod1+Shift+1" = "move container to workspace 1";
        "Mod1+Shift+2" = "move container to workspace 2";
        "Mod1+Shift+3" = "move container to workspace 3";
        "Mod1+Shift+4" = "move container to workspace 4";
        "Mod1+Shift+5" = "move container to workspace 5";

        # Move workspace to another monitor.
        "Mod1+Shift+l" = "move workspace to output left";
        "Mod1+Shift+r" = "move workspace to output right";

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
          background = theme.base00-hex;
          separator  = theme.base01-hex;
          statusline = theme.base04-hex;

          focusedWorkspace = {
            background  = theme.base03-hex;
            text        = theme.base0D-hex;
            border      = theme.base03-hex;
          };

          activeWorkspace = {
            background  = theme.base03-hex;
            text        = theme.base0D-hex;
            border      = theme.base03-hex;
          };

          inactiveWorkspace = {
            background  = theme.base01-hex;
            text        = theme.base05-hex;
            border      = theme.base03-hex;
          };

          urgentWorkspace = {
            background  = theme.base08-hex;
            text        = theme.base00-hex;
            border      = theme.base08-hex;
          };

          bindingMode = {
            background  = theme.base0A-hex;
            text        = theme.base00-hex;
            border      = theme.base00-hex;
          };
        };
      }];

      colors = {
        background  = theme.base07-hex;

        focused = {
          border      = theme.base03-hex;
          background  = theme.base0D-hex;
          text        = theme.base00-hex;
          indicator   = theme.base0D-hex;
          childBorder = theme.base03-hex;
        };

        focusedInactive = {
          border      = theme.base01-hex;
          background  = theme.base01-hex;
          text        = theme.base05-hex;
          indicator   = theme.base03-hex;
          childBorder = theme.base01-hex;
        };

        unfocused = {
          border      = theme.base01-hex;
          background  = theme.base00-hex;
          text        = theme.base05-hex;
          indicator   = theme.base01-hex;
          childBorder = theme.base01-hex;
        };

        urgent = {
          border      = theme.base08-hex;
          background  = theme.base08-hex;
          text        = theme.base00-hex;
          indicator   = theme.base08-hex;
          childBorder = theme.base08-hex;
        };

        placeholder = {
          border      = theme.base00-hex;
          background  = theme.base00-hex;
          text        = theme.base05-hex;
          indicator   = theme.base00-hex;
          childBorder = theme.base00-hex;
        };
      };

      window = {
        border = 1;
      };
    };
  };

  services = {
    # Add the network manager applet to the i3 bar tray.
    blueman-applet = {
      enable = true;
    };
  };

  xdg.configFile."i3/status.toml".text = ''
    [theme]
    name = "modern"

    [theme.overrides]
    idle_bg     = "${theme.base00-hex}"
    idle_fg     = "${theme.base05-hex}"
    good_bg     = "${theme.base00-hex}"
    good_fg     = "${theme.base05-hex}"
    info_bg     = "${theme.base00-hex}"
    info_fg     = "${theme.base05-hex}"
    warning_bg  = "${theme.base0A-hex}"
    warning_fg  = "${theme.base00-hex}"
    critical_bg = "${theme.base0C-hex}"
    critical_fg = "${theme.base00-hex}"

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
    clickable = false

    [[block]]
    block = "cpu"
    interval = 1

    [[block]]
    block = "battery"
    interval = 10
    format = "{percentage}% {time}"

    [[block]]
    block = "sound"
    step_width = 5

    [[block]]
    block = "time"
    interval = 60
    format = "%a %l:%M %p"
  '';
}
