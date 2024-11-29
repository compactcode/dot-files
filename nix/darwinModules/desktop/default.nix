{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.darwinModules.stylix
    inputs.home-manager.darwinModules.home-manager
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
            inputs.self.homeModules.nixvim
          ];
          home = {
            stateVersion = "24.05";
          };
          packages = with pkgs; [
            slack
          ];
          programs = {
            # web browser
            firefox.enable = true;
            # terminal
            kitty.enable = true;
          };
          stylix.targets.firefox.enable = true;
          stylix.targets.kitty.enable = true;
        };
      };

      # mdm user
      users.users.shanon = {
        name = "shanon";
        home = "/Users/shanon";
      };
    }
  ];
}
