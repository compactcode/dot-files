{ lib, pkgs, config, ... }:

let
  settings = import ../../../settings.nix;
  theme = import ../../themes/base_16_current.nix;

  downloadsDir = config.xdg.userDirs.download;
in {
  home.packages = with pkgs; [
    i3lock-color
  ];

  # Screenshot a selected area.
  xdg.dataFile."bin/screenshot-area" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      file=$(${lib.getBin pkgs.coreutils}/bin/date +%s).png

      ${lib.getBin pkgs.maim}/bin/maim -u -s ${downloadsDir}/$file

      # Handle when area selection is cancelled.
      if [[ -f "${downloadsDir}/$file" ]]; then
        ${lib.getBin pkgs.pinta}/bin/pinta ${downloadsDir}/$file
      fi
    '';
  };

  # Screenshot the current window.
  xdg.dataFile."bin/screenshot-window" = {
    executable = true;
    text = ''
      #!/bin/sh

      file=$(${lib.getBin pkgs.coreutils}/bin/date +%s).png

      ${lib.getBin pkgs.maim}/bin/maim -i $(${lib.getBin pkgs.xdotool}/bin/xdotool getactivewindow) ${downloadsDir}/$file

      ${lib.getBin pkgs.pinta}/bin/pinta ${downloadsDir}/$file
    '';
  };

  services = {
    screen-locker = {
      enable = true;
      inactiveInterval = 5;
      lockCmd = "${lib.getBin pkgs.i3lock-color}/bin/i3lock-color -n -c 000000";
    };
  };

  xsession.windowManager.i3 = {
    enable = true;

    package = pkgs.i3-gaps;

    extraConfig = ''
      set $web      "1:"
      set $code     "2:"
      set $code-alt "3:"
      set $files    "4:"
      set $chat     "5:"
      set $open     "6:"
      set $open-alt "7:"
      set $music    "8:"
      set $games    "9:"
    '';

    config = {
      keybindings = {
        # Switch to workspace.
        "Mod1+1"   = "workspace $web";
        "Mod1+2"   = "workspace $code";
        "Mod1+3"   = "workspace $code-alt";
        "Mod1+4"   = "workspace $files";
        "Mod1+5"   = "workspace $chat";
        "Mod1+6"   = "workspace $open";
        "Mod1+7"   = "workspace $open-alt";
        "Mod1+8"   = "workspace $music";
        "Mod1+9"   = "workspace $games";
        "Mod1+Tab" = "workspace back_and_forth";

        # Move applications to another workspace.
        "Mod1+Shift+1" = "move container to workspace $web";
        "Mod1+Shift+2" = "move container to workspace $code";
        "Mod1+Shift+3" = "move container to workspace $code-alt";
        "Mod1+Shift+4" = "move container to workspace $files";
        "Mod1+Shift+5" = "move container to workspace $chat";
        "Mod1+Shift+6" = "move container to workspace $open";
        "Mod1+Shift+7" = "move container to workspace $open-alt";
        "Mod1+Shift+8" = "move container to workspace $music";
        "Mod1+Shift+9" = "move container to workspace $games";

        # Move focus between windows.
        "Mod1+h" = "focus left";
        "Mod1+j" = "focus down";
        "Mod1+k" = "focus up";
        "Mod1+l" = "focus right";

        # Move current window within the current workspace.
        "Mod1+Shift+h" = "move left";
        "Mod1+Shift+j" = "move down";
        "Mod1+Shift+k" = "move up";
        "Mod1+Shift+l" = "move right";

        # Resize current window.
        "Mod1+Shift+Left"  = "resize shrink width 2 px or 2 ppt";
        "Mod1+Shift+Down"  = "resize grow height 2 px or 2 ppt";
        "Mod1+Shift+Up"    = "resize shrink height 2 px or 2 ppt";
        "Mod1+Shift+Right" = "resize grow width 2 px or 2 ppt";

        # Fullscreen current window.
        "Mod1+f" = "fullscreen toggle";

        # Toggle between stacking/tabbed/split.
        "Mod1+t" = "layout toggle";

        # Split window horizontally.
        "Mod1+x" = "split h";

        # Split window verticalally.
        "Mod1+v" = "split v";

        # Kill current window.
        "Mod1+w" = "kill";

        # Open a new terminal.
        "Mod1+Return" = "exec --no-startup-id alacritty";

        # Open a file browser in the downloads directory.
        "Mod4+d" = "workspace $files; exec --no-startup-id alacritty -e lf ${downloadsDir}";

        # Open a file browser.
        "Mod4+f" = "workspace $files; exec --no-startup-id alacritty -e lf";

        # Open an interactive application launcher.
        "Mod4+space" = "exec --no-startup-id rofi -show drun --lines 10";

        # Lock the screen.
        "Mod4+Shift+l" = "exec --no-startup-id ${lib.getBin pkgs.xautolock}/bin/xautolock -locknow";

        # Open a web browser.
        "Mod4+w" = "workspace $web; exec --no-startup-id firefox --new-tab about:home";

        # Screenshot a selected area.
        "Print" = "exec --no-startup-id ${config.xdg.dataFile."bin/screenshot-area".target}";

        # Screenshot the current window.
        "Shift+Print" = "exec --no-startup-id ${config.xdg.dataFile."bin/screenshot-window".target}";
      };

      gaps = {
        inner = 12;
        outer = 6;
      };

      bars = [{
        position = "top";

        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${config.xdg.configHome}/i3status-rust/config-default.toml";

        fonts = [
          "${settings.font.iconFamily} ${settings.font.defaultSize.points}"
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
        titlebar = false;

        commands = [
          { command = "move to workspace $music"; criteria = { class = "Spotify"; }; }
        ];
      };

      floating = {
        border = 1;
        titlebar = false;
      };

      assigns = {
        "$web" = [
          { class = "^Firefox$"; }
        ];
        "$chat" = [
          { class = "^Slack$"; }
          { class = "^discord$"; }
          { class = "^Signal$"; }
        ];
        "$games" = [
          { class = "^Steam$"; }
        ];
      };
    };
  };

  programs = {
    i3status-rust = {
      enable = true;

      bars = {
        default = {
          blocks = [
            {
              block = "disk_space";
              path = "/";
              alias = "/";
              info_type = "available";
              unit = "GB";
            }
            {
              block = "memory";
              display_type = "memory";
              format_mem = "{Mup}%";
              interval = 4;
              clickable = false;
            }
            {
              block = "cpu";
              interval = 2;
              format = "{utilization} {frequency}";
            }
            {
              block = "load";
              format = "{1m} {5m}";
              interval = 4;
            }
            {
              block = "temperature";
              collapsed = false;
              interval = 4;
              format = "{max}°";
              chip = "k10temp-pci-*";
            }
            {
              block = "net";
              device = "eno1";
              interval = 2;
            }
            {
              block = "sound";
              step_width = 6;
            }
            {
              block = "time";
              interval = 60;
              format = "%d %b %l:%M %p";
            }
          ];

          settings = {
            theme =  {
              name = "modern";
              overrides = {
                idle_bg     = "${theme.base00-hex}";
                idle_fg     = "${theme.base05-hex}";
                good_bg     = "${theme.base00-hex}";
                good_fg     = "${theme.base05-hex}";
                info_bg     = "${theme.base00-hex}";
                info_fg     = "${theme.base05-hex}";
                warning_bg  = "${theme.base0A-hex}";
                warning_fg  = "${theme.base00-hex}";
                critical_bg = "${theme.base0C-hex}";
                critical_fg = "${theme.base00-hex}";
              };
            };
            icons = {
              overrides = {
                cogs = " ";
                cpu = " ";
                memory_mem = " ";
                net_down = "";
                net_up = "";
                net_wired = "";
                net_wireless = "";
                thermometer = " ";
                time = " ";
                volume_empty = " ";
                volume_full = " ";
                volume_half = "奔 ";
                volume_muted = "ﱝ ";
              };
            };
          };
        };
      };
    };
  };
}
