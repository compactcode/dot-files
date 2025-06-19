{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./nixos/disko/desktop.nix
    ./nixos/core.nix
    ./nixos/desktop/core.nix
    ./nixos/desktop/hyprland.nix
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.shandogs = {
          imports = [
            inputs.nixvim.homeManagerModules.nixvim
            inputs._1password-shell-plugins.hmModules.default
            inputs.self.homeModules.cli-core
            inputs.self.homeModules.cli-development
            inputs.self.homeModules.gui-core
            inputs.self.homeModules.gui-wayland
          ];
        };
      };
    }
  ];
}
