{
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {  home-manager, nixpkgs, ... }: {
    nixosConfigurations.nixpad = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nixpad.nix
        ./system.nix
        home-manager.nixosModules.home-manager ({
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.shandogs = { ... }: {
            imports = [
              ./services/gpg.nix
              ./programs/neovim.nix
              ./programs/zsh.nix
            ];
          };
        })
      ];
    };
  };
}
