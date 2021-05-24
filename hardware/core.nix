{ ... }: {
  # Enable non free firmware.
  hardware = {
    enableRedistributableFirmware = true;
  };

  # Enable updating firmware via the command line.
  services = {
    fwupd = {
      enable = true;
    };
  };
}
