{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.darwinModules.stylix
    inputs.home-manager.darwinModules.home-manager
    ./aerospace
    ./core.nix
    ./homebrew.nix
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.shanon = {
          imports = [
            inputs.nixvim.homeManagerModules.nixvim
            inputs._1password-shell-plugins.hmModules.default
            inputs.self.homeModules.cli-core
            inputs.self.homeModules.cli-development
            inputs.self.homeModules.gui-core
          ];
          home = {
            packages = with pkgs; [
              bruno # api explorer
              nh # nix cli helper
              podman # container manager
              slack # messenger
            ];
            stateVersion = "24.05";
          };
        };
      };

      # mdm user
      users.users.shanon = {
        name = "shanon";
        home = "/Users/shanon";
      };

      # temporary nix-darwin option
      system.primaryUser = "shanon";
    }
  ];
}
