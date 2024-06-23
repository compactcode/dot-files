{inputs, ...}: {
  system = "x86_64-linux";
  modules = [
    ./hardware.nix
    inputs.self.nixosModules.desktop
    {
      disko.devices.disk.main.device = "/dev/disk/by-id/nvme-KXG6AZNV512G_TOSHIBA_79CS12AKTYSQ";

      home-manager.users.shandogs = {
        home.stateVersion = "24.05";
      };

      networking.hostName = "prophet";

      system.stateVersion = "24.05";
    }
  ];
}
