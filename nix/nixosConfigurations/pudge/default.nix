{inputs, ...}: {
  system = "x86_64-linux";
  modules = [
    ../../../hardware/pudge.nix
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
      };
    }
  ];
}
