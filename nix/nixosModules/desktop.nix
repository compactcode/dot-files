{inputs, ...}: {
  imports =[
    inputs.disko.nixosModules.disko
    ./nixos/disko/desktop.nix
    ./nixos/core.nix
    ./nixos/desktop/core.nix
    ./nixos/desktop/hyprland.nix
    ./nixos/work/zepto.nix
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.shandogs = {
          imports = [
            inputs.nixvim.homeManagerModules.nixvim
            inputs._1password-shell-plugins.hmModules.default
            ./home/cli.nix
            ./home/gui.nix
            ./home/nixvim
            ./home/ssh.nix
          ];
        };
      };
    }
  ];
}
