{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./nixos/disko/server.nix
    ./nixos/core.nix
    ./nixos/server/core.nix
    ./nixos/server/automation.nix
    ./nixos/server/media.nix
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.shandogs = {
          imports = [
            ./home/server.nix
          ];
        };
      };
    }
  ];
}
