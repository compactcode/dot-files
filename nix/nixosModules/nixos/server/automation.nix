{...}: {
  networking.firewall = {
    allowedTCPPorts = [8123];
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers.homeassistant = {
      environment = {
        TZ = "Australia/Melbourne";
        PUID = "1001"; # service user
        PGID = "1001"; # service group
      };
      extraOptions = [
        "--network=host"
      ];
      image = "lscr.io/linuxserver/homeassistant:2024.7.2";
      ports = [
        "8123:8123"
      ];
      volumes = [
        "/mnt/nas/config/homeassistant:/config"
      ];
    };
  };
}
