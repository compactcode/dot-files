{...}: {
  services = {
    # remote access
    openssh = {
      enable = true;
      settings = {
        # public key only
        PasswordAuthentication = false;
        # public key only
        KbdInteractiveAuthentication = false;
      };
    };
  };

  users = {
    # dedicated group for running services
    groups.services = {
      gid = 1001;
    };

    users = {
      shandogs = {
        extraGroups = [
          "docker" # allow docker control
          "services" # allow service editing
        ];
        # give myself ssh access
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDPCP4SqkSwxkX9dkk36idNz7wCtXfa84hwkkflJVuDF"
        ];
      };

      # A dedicated user for running services
      services = {
        isNormalUser = true;
        uid = 1001;
        extraGroups = [
          "services"
        ];
      };
    };
  };

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    storageDriver = "btrfs";
  };
}
