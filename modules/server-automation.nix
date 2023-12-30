{ pkgs, ... }:

{
  virtualisation.oci-containers = {
    backend = "docker";
    containers.homeassistant = {
      volumes = [
        "home-assistant:/config"
      ];
      environment = {
        TZ = "Australia/Melbourne";
        PUID = "1001"; # service user
        GUID = "1001"; # service group
      };
      image = "lscr.io/linuxserver/home-assistant:2023.12.4"; # Warning: if the tag does not change, the image will not be updated
      extraOptions = [
        "--network=host"
      ];
    };
  };
}
