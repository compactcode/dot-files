{
  inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, disko, home-manager, neovim-nightly-overlay, stylix, ... }:
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

        pheonix = nixpkgs.lib.nixosSystem {
          inherit system pkgs;

          modules = [
            disko.nixosModules.disko
            ./hardware/pheonix.nix
            ./hardware/disko/pheonix.nix
            ./modules/desktop-hyprland.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.shandogs = {
                imports = [
                  stylix.homeManagerModules.stylix
                  ./home/cli.nix
                  ./home/gui.nix
                ];

                home = {
                  stateVersion = "23.11";
                };
              };
            }
          ];
        };

        pudge = nixpkgs.lib.nixosSystem {
          inherit system pkgs;

          modules = [
            ./hardware/pudge.nix
            ./modules/server.nix
            ./modules/server-automation.nix
            ./modules/server-media.nix
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
