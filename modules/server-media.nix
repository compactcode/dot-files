{ pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [ 8096 ];
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers.emby = {
      environment = {
        TZ = "Australia/Melbourne";
        PUID = "1001"; # service user
        PGID = "1001"; # service group
      };
      image = "lscr.io/linuxserver/emby:4.7.14.0-ls180";
      ports = [
        "8096:8096"
      ];
      volumes = [
        "emby:/config"
      ];
    };
  };
}
