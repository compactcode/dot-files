{inputs, ...}: {
  system = "x86_64-linux";
  modules = [
    ./hardware.nix
    inputs.self.nixosModules.server
    {
      disko.devices.disk.main.device = "/dev/disk/by-id/ata-AirDisk_512GB_SSD_NFG246R002163S30WX";

      home-manager.users.shandogs = {
        home.stateVersion = "22.11";
      };

      networking.hostName = "pudge";

      system.stateVersion = "23.05";
    }
  ];
}
