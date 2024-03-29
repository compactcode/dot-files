{ pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [
      7878
      8096
      8989
      9091
      9696
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

      gluetun = {
        environmentFiles = [
          "/run/secret/gluetun.env" # not managed by nix
        ];
        environment = {
          SERVER_COUNTRIES = "Australia";
        };
        extraOptions = [
          "--cap-add=NET_ADMIN"
        ];
        image = "ghcr.io/qdm12/gluetun:v3.37.0";
        ports = [
          "7878:7878" # radarr
          "8989:8989" # sonarr
          "9091:9091" # transmission
          "9696:9696" # prowlarr
        ];
      };

      prowlarr = {
        dependsOn = [
          "gluetun"
        ];
        environment = {
          PUID = "1001"; # service user
          PGID = "1001"; # service group
        };
        extraOptions = [
          "--network=container:gluetun"
        ];
        image = "lscr.io/linuxserver/prowlarr:1.11.4.4173-ls45";
        volumes = [
          "/mnt/nas/config/prowlarr:/config"
        ];
      };

      radarr = {
        dependsOn = [
          "gluetun"
          "prowlarr"
          "transmission"
        ];
        environment = {
          TZ = "Australia/Melbourne";
          PUID = "1001"; # service user
          PGID = "1001"; # service group
        };
        extraOptions = [
          "--network=container:gluetun"
        ];
        image = "lscr.io/linuxserver/radarr:5.2.6.8376-ls197";
        volumes = [
          "/mnt/nas/config/radarr:/config"
          "/mnt/nas/media:/data"
        ];
      };

      sonarr = {
        dependsOn = [
          "gluetun"
          "prowlarr"
          "transmission"
        ];
        environment = {
          TZ = "Australia/Melbourne";
          PUID = "1001"; # service user
          PGID = "1001"; # service group
        };
        extraOptions = [
          "--network=container:gluetun"
        ];
        image = "lscr.io/linuxserver/sonarr:4.0.0.741-ls219";
        volumes = [
          "/mnt/nas/config/sonarr:/config"
          "/mnt/nas/media:/data"
        ];
      };

      transmission = {
        dependsOn = [
          "gluetun"
        ];
        environment = {
          PUID = "1001"; # service user
          PGID = "1001"; # service group
        };
        extraOptions = [
          "--network=container:gluetun"
        ];
        image = "lscr.io/linuxserver/transmission:4.0.5-r0-ls220";
        volumes = [
          "/mnt/nas/config/transmission:/config"
          "/mnt/nas/media:/data"
        ];
      };
    };
  };
}
