{ pkgs, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      keybindings = {
        "Mod1+Return" = "exec alacritty";
      };

      gaps = {
        inner = 12;
        outer = 12;
      };
    };
  };
}
