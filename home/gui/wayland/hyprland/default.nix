{config, ...}: {
  # window manager
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";

      bind = [
        # applications tied to particular workspaces
        "$mod, a, exec, ~/.local/share/rofi/project.sh"
        "$mod, d, exec, ~/.local/share/hyprland/focus.sh 5 vesktop vesktop"
        "$mod, e, exec, ~/.local/share/hyprland/project.sh 3"
        "$mod, n, exec, ~/.local/share/hyprland/focus.sh 1 firefox firefox"
        "$mod, o, exec, ~/.local/share/hyprland/focus.sh 4 obsidian obsidian"
        "$mod, r, exec, ~/.local/share/hyprland/focus.sh 5 Slack slack"
        "$mod, s, exec, ~/.local/share/hyprland/project.sh 2"

        # applications
        "$mod, i, exec, rofi -show drun"
        "$mod, b, exec, ~/.local/share/rofi/bookmark.sh"
        "$mod, t, exec, kitty"
        "$mod, f, exec, kitty yazi"
        "$mod, p, exec, grimblast --notify edit area"
        "$mod, v, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

        # focused window actions
        "$mod, w, togglefloating,"
        "$mod, q, killactive,"

        # open workspaces
        "$mod, TAB, workspace, previous"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"

        # move windows
        "$mod+Shift, 1, movetoworkspace, 1"
        "$mod+Shift, 2, movetoworkspace, 2"
        "$mod+Shift, 3, movetoworkspace, 3"
        "$mod+Shift, 4, movetoworkspace, 4"
        "$mod+Shift, 5, movetoworkspace, 5"
        "$mod+Shift, 6, movetoworkspace, 6"
        "$mod+Shift, 7, movetoworkspace, 7"
        "$mod+Shift, 8, movetoworkspace, 8"
        "$mod+Shift, 9, movetoworkspace, 9"
      ];

      bindm = [
        # move windows with left mouse
        "$mod, mouse:272, movewindow"
        # resize windows with right mouse
        "$mod, mouse:273, resizewindow"
      ];

      decoration = {
        # TODO: extract an option
        rounding = 5;
      };

      # load user session variables
      env = [
        "XDG_PROJECTS_DIR, ${config.home.sessionVariables.XDG_PROJECTS_DIR}"
      ];

      general = {
        gaps_out = 15;
      };

      misc = {
        # disable built in logo
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      windowrulev2 = [
        "workspace 5, class:^(Slack)$"
        "workspace 9, class:^(steam)$"
      ];
    };

    extraConfig = ''
      bind = $mod, u, submap, focused

      submap = focused

      bind = , f, fullscreen,

      # focus windows
      bind = , left, movefocus, l
      bind = , right, movefocus, r
      bind = , up, movefocus, u
      bind = , down, movefocus, d

      # resize windows
      binde = CTRL, right, resizeactive, 10 0
      binde = CTRL, left, resizeactive, -10 0
      binde = CTRL, up, resizeactive, 0 -10
      binde = CTRL, down, resizeactive, 0 10

      # move windows
      bind = SHIFT, left, movewindow, l
      bind = SHIFT, right, movewindow, r
      bind = SHIFT, up, movewindow, u
      bind = SHIFT, down, movewindow, d

      bind = , escape, submap, reset

      submap = reset
    '';

    # hyprland-session.target
    systemd.enable = true;
  };

  xdg = {
    dataFile = {
      # focus application on a given workspace
      "hyprland/focus.sh" = {
        executable = true;
        source = ./scripts/focus.sh;
      };

      # focus project on a given workspace
      "hyprland/project.sh" = {
        executable = true;
        source = ./scripts/project.sh;
      };
    };
  };
}
