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
