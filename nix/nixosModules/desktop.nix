{inputs, ...}: {
  imports =[
    inputs.disko.nixosModules.disko
    ../../modules/disko/desktop.nix
    ../../modules/core.nix
    ../../modules/desktop/core.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/work/zepto.nix
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.shandogs = {
          imports = [
            inputs.nixvim.homeManagerModules.nixvim
            inputs._1password-shell-plugins.hmModules.default
            ../../home/cli.nix
            ../../home/gui.nix
            ../../home/nixvim
            ../../home/ssh.nix
          ];
        };
      };
    }
  ];
}
