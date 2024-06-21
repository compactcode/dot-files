{inputs, ...}: {
  system = "x86_64-linux";
  modules = [
    inputs.disko.nixosModules.disko
    ./hardware.nix
    ./filesytem.nix
    ../../../modules/core.nix
    ../../../modules/desktop/core.nix
    ../../../modules/desktop/hyprland.nix
    ../../../modules/work/zepto.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
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

        home.stateVersion = "23.11";
      };

      networking.hostName = "pheonix";

      system.stateVersion = "23.11";
    }
  ];
}
