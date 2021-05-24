{ ... }: {
  services = {
    picom = {
      enable = true;
      backend = "glx";
      fade = true;
      fadeDelta = 5;
      inactiveOpacity = 0.950;
      opacityRules = [
        "100:class_g = 'Firefox'"
        "100:class_g = 'discord'"
        "100:class_g = 'zoom'"
      ];
      shadow = true;
      vSync = true;
    };
  };
}
