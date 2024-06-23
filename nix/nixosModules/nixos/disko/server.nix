{
  disko.devices = {
    disk = {
      vdb = {
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "512MiB";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                subvolumes = {
                  "/root" = {
                    mountOptions = ["compress=zstd"];
                    mountpoint = "/";
                  };
                  "/home" = {
                    mountOptions = ["compress=zstd"];
                    mountpoint = "/home";
                  };
                  "/nix" = {
                    mountOptions = ["compress=zstd" "noatime"];
                    mountpoint = "/nix";
                  };
                  "/swap" = {
                    mountpoint = "/swap";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
