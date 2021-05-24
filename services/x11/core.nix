{ ... }: {
  services = {
    xserver = {
      enable = true;

      displayManager = {
        # Skip login since we just unlocked the encrypted drive.
        autoLogin = {
          enable = true;
          user = "shandogs";
        };

        lightdm = {
          enable = true;
        };
      };

      windowManager = {
        i3 = {
          enable = true;
        };
      };

      # Turn caps lock into another ctrl.
      xkbOptions = "ctrl:nocaps";
    };
  };
}
