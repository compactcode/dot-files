{
  inputs = {
    _1password-shell-plugins = {
      url = "github:1Password/shell-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix = {
      url = "github:danth/stylix";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = inputs @ {
    disko,
    home-manager,
    neovim-nightly-overlay,
    nixpkgs,
    nixvim,
    stylix,
    ...
  }: let
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
      medusa = nixpkgs.lib.nixosSystem {
        inherit system pkgs;

        modules = [
          ./hardware/medusa.nix
          ./modules/desktop.nix
          home-manager.nixosModules.home-manager
          {
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
          ./modules/core.nix
          ./modules/desktop/core.nix
          ./modules/desktop/hyprland.nix
          ./modules/work/zepto.nix
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.shandogs = {
              imports = [
                nixvim.homeManagerModules.nixvim
                inputs._1password-shell-plugins.hmModules.default
                ./home/cli.nix
                ./home/gui.nix
                ./home/nixvim.nix
                ./home/ssh.nix
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
          home-manager.nixosModules.home-manager
          {
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
          disko.nixosModules.disko
          ./hardware/prophet.nix
          ./hardware/disko/prophet.nix
          ./modules/core.nix
          ./modules/desktop/core.nix
          ./modules/desktop/hyprland.nix
          ./modules/work/zepto.nix
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.shandogs = {
              imports = [
                nixvim.homeManagerModules.nixvim
                inputs._1password-shell-plugins.hmModules.default
                ./home/cli.nix
                ./home/gui.nix
                ./home/nixvim.nix
                ./home/ssh.nix
              ];

              home = {
                stateVersion = "24.05";
              };
            };

            system = {
              stateVersion = "24.05";
            };
          }
        ];
      };
    };
  };
}
