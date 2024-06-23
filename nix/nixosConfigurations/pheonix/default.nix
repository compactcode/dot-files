{inputs, ...}: {
  system = "x86_64-linux";
  modules = [
    ./hardware.nix
    inputs.self.nixosModules.desktop
    {
      disko.devices.disk.main.device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_2TB_S4J4NF0NA04068A";

      home-manager.users.shandogs = {
        home.stateVersion = "23.11";
      };

      networking.hostName = "pheonix";

      system.stateVersion = "23.11";
    }
  ];
}
