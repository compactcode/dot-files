{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;

        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.medusa = nixpkgs.lib.nixosSystem {
        inherit system pkgs;

        modules = [
          ./hardware/medusa.nix
          ./system.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.shandogs = {
              imports = [
                ./home.nix
              ];
            };
          }
        ];
      };
    };
}
