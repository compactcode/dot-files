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
            inputs.self.homeModules.gui-1password
          ];
          home = {
            packages = with pkgs; [
              discord # voice/video chat
              obsidian # document manager
              slack # messenger
            ];
            stateVersion = "24.05";
          };
          programs = {
            # terminal
            kitty = {
              enable = true;
              settings = {
                # allow using the alt key
                macos_option_as_alt = "both";
              };
            };
          };
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
