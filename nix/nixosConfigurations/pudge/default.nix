{inputs, ...}: {
  system = "x86_64-linux";
  modules = [
    inputs.disko.nixosModules.disko
    ./hardware.nix
    ./filesystem.nix
    ../../../modules/server.nix
    ../../../modules/server-automation.nix
    ../../../modules/server-media.nix
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.shandogs = {
        imports = [
          ../../../modules/server-home.nix
        ];

        home.stateVersion = "22.11";
      };

      networking.hostName = "pudge";

      system.stateVersion = "23.05";
    }
  ];
}
