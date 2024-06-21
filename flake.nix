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
    flakelight = {
      url = "github:nix-community/flakelight";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
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

  outputs = {flakelight, ...} @ inputs:
    flakelight.lib.mkFlake ./. {
      nixpkgs.config = {allowUnfree = true;};

      nixosConfigurations = {
        pudge = {
          system = "x86_64-linux";
          modules = [
            ./hardware/pudge.nix
            ./modules/server.nix
            ./modules/server-automation.nix
            ./modules/server-media.nix
            inputs.home-manager.nixosModules.home-manager
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

        prophet = {
          system = "x86_64-linux";
          modules = [
            inputs.disko.nixosModules.disko
            ./hardware/prophet.nix
            ./hardware/disko/prophet.nix
            ./modules/core.nix
            ./modules/desktop/core.nix
            ./modules/desktop/hyprland.nix
            ./modules/work/zepto.nix
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.shandogs = {
                imports = [
                  inputs.nixvim.homeManagerModules.nixvim
                  inputs._1password-shell-plugins.hmModules.default
                  ./home/cli.nix
                  ./home/gui.nix
                  ./home/nixvim
                  ./home/ssh.nix
                ];

                home.stateVersion = "24.05";
              };

              system.stateVersion = "24.05";
            }
          ];
        };
      };
    };
}
