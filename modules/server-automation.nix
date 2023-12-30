{ pkgs, ... }:

{
  virtualisation.oci-containers = {
    backend = "docker";
    containers.homeassistant = {
      extraOptions = [
        "--network=host"
      ];
      environment = {
        TZ = "Australia/Melbourne";
        PUID = "1001"; # service user
        GUID = "1001"; # service group
      };
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
