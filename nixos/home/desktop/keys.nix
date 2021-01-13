{ config, lib, pkgs, ... }:

let
  download = config.xdg.userDirs.download;

  date = "${lib.getBin pkgs.coreutils}/bin/date";
  launcher = "${lib.getBin pkgs.i3}/bin/i3-msg exec";
  maim = "${lib.getBin pkgs.maim}/bin/maim";
  pinta = "${lib.getBin pkgs.pinta}/bin/pinta";
  xdotool = "${lib.getBin pkgs.xdotool}/bin/xdotool";

in {
  services.sxhkd = {
    enable = true;

    keybindings = {
      "XF86AudioMute" = "${lib.getBin pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
      "XF86AudioLowerVolume" = "${lib.getBin pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
      "XF86AudioRaiseVolume" = "${lib.getBin pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";

      "XF86AudioMicMute" = "${lib.getBin pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";

      "XF86MonBrightnessDown" = "${lib.getBin pkgs.brightnessctl}/bin/brightnessctl s 5%-";
      "XF86MonBrightnessUp" = "${lib.getBin pkgs.brightnessctl}/bin/brightnessctl s +5%";

      # Open an interactive application launcher.
      "super + space" = "${launcher} '${lib.getBin pkgs.rofi}/bin/rofi -show drun --lines 10'";
      "super + s" = "${launcher} '${config.xdg.dataFile."bin/duckduckgo".target}'";

      # Launch a new terminal.
      "{super, alt} + Return" = "${launcher} '${lib.getBin pkgs.alacritty}/bin/alacritty'";

      # Launch firefox.
      "super + w" = "${launcher} 'firefox-sandboxed'";

      # Lock the screen.
      "super + shift + l" = "${launcher} '${lib.getBin pkgs.xautolock}/bin/xautolock -locknow'";

      # Screenshot a selected area.
      "Print" = "file=$(${date} +%s).png; ${maim} -u -s ${download}/$file; ${pinta} ${download}/$file";

      # Screenshot the current window.
      "shift + Print" = "file=$(${date} +%s).png; ${maim} -i $(${xdotool} getactivewindow) ${download}/$file; ${pinta} ${download}/$file";
    };
  };
}
