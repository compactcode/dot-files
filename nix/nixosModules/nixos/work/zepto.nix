{lib, pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      cloudflare-warp # vpn
    ];
  };

  networking = {
    extraHosts = ''
      127.0.0.1 api.split.test
      127.0.0.1 go.split.test
    '';
  };

  systemd = {
    services = {
      cloudflare-warp = {
        description = "cloudflare warp vpn";
        serviceConfig = {
          AmbientCapabilities = ["CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE" "CAP_SYS_PTRACE"];
          CapabilityBoundingSet = ["CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE" "CAP_SYS_PTRACE"];
          ExecStart = "${lib.getExe' pkgs.cloudflare-warp "warp-svc"}";
          Type = "simple";
        };
      };
    };
  };
}
