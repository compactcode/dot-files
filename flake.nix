{
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
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
      nixosConfigurations = {
        bounty = nixpkgs.lib.nixosSystem {
          inherit system pkgs;

          modules = [
            ./hardware/bounty.nix
            ./modules/server.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.shandogs = {
                imports = [
                  ./modules/server-home.nix
                ];
              };
            }
          ];
        };

        medusa = nixpkgs.lib.nixosSystem {
          inherit system pkgs;

          modules = [
            ./hardware/medusa.nix
            ./modules/desktop.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.shandogs = {
                imports = [
                  ./modules/desktop-home.nix
                ];
              };
            }
          ];
        };

        pudge = nixpkgs.lib.nixosSystem {
          inherit system pkgs;

          modules = [
            ./hardware/pudge.nix
            ./modules/server.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.shandogs = {
                imports = [
                  ./modules/server-home.nix
                ];
              };
            }
          ];
        };

        prophet = nixpkgs.lib.nixosSystem {
          inherit system pkgs;

          modules = [
            ./hardware/prophet.nix
            ./modules/desktop.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.shandogs = {
                imports = [
                  ./modules/desktop-home.nix
                ];
              };
            }
          ];
        };
      };
    };
}
