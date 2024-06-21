{inputs, ...}: {
  system = "x86_64-linux";
  modules = [
    inputs.disko.nixosModules.disko
    ./hardware.nix
    ./filesystem.nix
    ../../../modules/core.nix
    ../../../modules/desktop/core.nix
    ../../../modules/desktop/hyprland.nix
    ../../../modules/work/zepto.nix
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.shandogs = {
        imports = [
          inputs.nixvim.homeManagerModules.nixvim
          inputs._1password-shell-plugins.hmModules.default
          ../../../home/cli.nix
          ../../../home/gui.nix
          ../../../home/nixvim
          ../../../home/ssh.nix
        ];

        home.stateVersion = "24.05";
      };

      networking.hostName = "prophet";

      system.stateVersion = "24.05";
    }
  ];
}
