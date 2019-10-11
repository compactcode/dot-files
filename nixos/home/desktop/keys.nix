{ pkgs, ... }:

{
  services.sxhkd = {
    enable = true;

    keybindings = {
      "XF86AudioMute" = "${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
      "XF86AudioLowerVolume" = "${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
      "XF86AudioRaiseVolume" = "${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";

      "XF86AudioMicMute" = "${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";

      "XF86MonBrightnessDown" = "${pkgs.brightnessctl}/bin/brightnessctl s 5%-";
      "XF86MonBrightnessUp" = "${pkgs.brightnessctl}/bin/brightnessctl s +5%";
    };
  };
}
