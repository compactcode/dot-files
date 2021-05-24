{ ... }: {
  services.xserver = {
    libinput = {
      enable = true;
      accelSpeed = "0.5";
    };
  };
}
