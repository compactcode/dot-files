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
                  package = pkgs.nodejs_18;
                  yarn.enable = true;
                };

                ruby = {
                  enable = true;
                  package = pkgs.ruby;
                };

                # needed for node gyp
                python = {
                  enable = true;
                  package = pkgs.python310;
                };
              };

              packages = with pkgs; [
                # cabybara js driver
                chromedriver
                chromium
                # psych(ruby-lsp)
                libyaml
              ];

              services = {
                redis = {
                  enable = true;
                  package = pkgs.redis;
                };

                postgres = {
                  enable = true;
                  package = pkgs.postgresql_12;
                  initialDatabases = [
                    {name = "split_development";}
                    {name = "split_test";}
                  ];
                  initialScript = ''
                    CREATE USER postgres SUPERUSER;
                  '';
                };
              };

              processes = {
                web = {
                  exec = "bundle exec rails server";
                  process-compose = {
                    availability = {
                      restart = "on_failure";
                    };
                    depends_on = {
                      postgres = {
                        condition = "process_healthy";
                      };
                    };
                  };
                };

                worker = {
                  exec = "bundle exec sidekiq";
                  process-compose = {
                    availability = {
                      restart = "on_failure";
                    };
                    depends_on = {
                      redis = {
                        condition = "process_healthy";
                      };
                      postgres = {
                        condition = "process_healthy";
                      };
                    };
                  };
                };
              };
            }
          ];
        };
      });
  };
}
