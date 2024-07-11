{
  inputs = {
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = {
    self,
    nixpkgs,
    devenv,
    systems,
    ...
  } @ inputs: let
    forEachSystem = nixpkgs.lib.genAttrs (import systems);
  in {
    packages = forEachSystem (system: {
      devenv-up = self.devShells.${system}.default.config.procfileScript;
    });

    devShells =
      forEachSystem
      (system: let
        pkgs = import nixpkgs {config.allowUnfree = true;};
      in {
        default = devenv.lib.mkShell {
          inherit inputs pkgs;

          modules = [
            {
              # https://devenv.sh/reference/options/

              languages = {
                javascript = {
                  enable = true;
                  package = pkgs.nodejs_20;
                };

                ruby = {
                  enable = true;
                  package = pkgs.ruby_3_3;
                };

                terraform = {
                  enable = true;
                  package = pkgs.terraform;
                };
              };

              packages = with pkgs; [
                gnumake
              ];
            }
          ];
        };
      });
  };
}
