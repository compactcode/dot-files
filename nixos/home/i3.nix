{ pkgs, ... }:

{
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
        outer = 12;
      };
    };
  };
}
