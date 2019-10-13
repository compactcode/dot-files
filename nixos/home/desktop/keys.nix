{ lib, pkgs, ... }:

let
  launcher = "${lib.getBin pkgs.i3}/bin/i3-msg exec";

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

      "super + space" = "${launcher} '${lib.getBin pkgs.rofi}/bin/rofi -show run --lines 10'";
      "super + Return" = "${launcher} '${lib.getBin pkgs.alacritty}/bin/alacritty'";
      "super + w" = "${launcher} '${lib.getBin pkgs.firefox}/bin/firefox'";
    };
  };
}
