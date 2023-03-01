{
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
  };

  outputs = { self, nixpkgs, home-manager, neovim-nightly-overlay }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;

        config.allowUnfree = true;

        overlays = [
          neovim-nightly-overlay.overlay
        ];
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
