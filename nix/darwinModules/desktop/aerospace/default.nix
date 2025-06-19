{pkgs, ...}: {
  services.aerospace = {
    enable = true;

    settings = {
      accordion-padding = 30;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";

      gaps = {
        inner.horizontal = 8;
        inner.vertical = 8;
        outer.left = 8;
        outer.bottom = 8;
        outer.top = 8;
        outer.right = 8;
      };

      mode.main.binding = {
        alt-shift-ctrl-cmd-1 = "workspace 1";
        alt-shift-ctrl-cmd-2 = "workspace 2";
        alt-shift-ctrl-cmd-3 = "workspace 3";
        alt-shift-ctrl-cmd-4 = "workspace 4";
        alt-shift-ctrl-cmd-5 = "workspace 5";

        alt-shift-ctrl-cmd-s = "exec-and-forget open -a ${pkgs.slack}/Applications/Slack.app";
        alt-shift-ctrl-cmd-t = "exec-and-forget open -a ${pkgs.kitty}/Applications/Kitty.app";
        alt-shift-ctrl-cmd-c = "exec-and-forget open -a /System/Applications/Calendar.app";

        alt-shift-ctrl-cmd-m = "exec-and-forget open -a /System/Applications/Mail.app";
        alt-shift-ctrl-cmd-n = "exec-and-forget open -a /Applications/Google\\ Chrome.app";
        alt-shift-ctrl-cmd-o = "exec-and-forget open -a ${pkgs.obsidian}/Applications/Obsidian.app";

        alt-shift-ctrl-1 = "move-node-to-workspace 1";
        alt-shift-ctrl-2 = "move-node-to-workspace 2";
        alt-shift-ctrl-3 = "move-node-to-workspace 3";
        alt-shift-ctrl-4 = "move-node-to-workspace 4";
        alt-shift-ctrl-5 = "move-node-to-workspace 5";

        alt-shift-ctrl-a = "layout accordion horizontal vertical";
        alt-shift-ctrl-t = "layout tiles horizontal vertical";

        alt-shift-ctrl-m = "focus left";
        alt-shift-ctrl-n = "focus down";
        alt-shift-ctrl-e = "focus up";
        alt-shift-ctrl-i = "focus right";
      };
    };
  };
}
