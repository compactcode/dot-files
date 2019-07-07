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

        # Logout.
        "Mod1+q" = "exec i3-msg exit";
      };

      gaps = {
        inner = 12;
        outer = 12;
      };
    };
  };
}
