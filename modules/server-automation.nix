{ pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [ 8123 ];
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
      image = "lscr.io/linuxserver/homeassistant:2023.12.4";
      ports = [
        "8123:8123"
      ];
      volumes = [
        "home-assistant:/config"
      ];
    };
  };
}
