{ pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [
      7878
      8096
      8989
    ];
  };

  virtualisation.oci-containers = {
    backend = "docker";

    containers = {
      emby = {
        environment = {
          PUID = "1001"; # service user
          PGID = "1001"; # service group
        };
        image = "lscr.io/linuxserver/emby:4.7.14.0-ls180";
        ports = [
          "8096:8096"
        ];
        volumes = [
          "/mnt/nas/config/emby:/config"
          "/mnt/nas/media:/data"
        ];
      };

      radarr = {
        environment = {
          TZ = "Australia/Melbourne";
          PUID = "1001"; # service user
          PGID = "1001"; # service group
        };
        image = "lscr.io/linuxserver/radarr:5.2.6.8376-ls197";
        ports = [
          "7878:7878"
        ];
        volumes = [
          "/mnt/nas/config/radarr:/config"
          "/mnt/nas/media:/data"
        ];
      };

      sonarr = {
        environment = {
          TZ = "Australia/Melbourne";
          PUID = "1001"; # service user
          PGID = "1001"; # service group
        };
        image = "lscr.io/linuxserver/sonarr:4.0.0.741-ls219";
        ports = [
          "8989:8989"
        ];
        volumes = [
          "/mnt/nas/config/sonarr:/config"
          "/mnt/nas/media:/data"
        ];
      };
    };
  };
}
