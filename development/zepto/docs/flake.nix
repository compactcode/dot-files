{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-ruby = {
      url = "github:bobvanderlinden/nixpkgs-ruby";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs-ruby, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;

          config = {
            allowUnfree = true;
          };
        };

        ruby = nixpkgs-ruby.packages.${system}."ruby-3.0.3";
      in {
        devShells.default = with pkgs;
          mkShell {
            buildInputs = [
              ruby

              nodejs-16_x
              (yarn.override { nodejs = nodejs-16_x; })
            ];

            shellHook = ''
              export GEM_HOME=./tmp/gem/ruby
              export GEM_PATH=$GEM_HOME
              export PATH=$GEM_HOME/bin:$PATH
              export PATH=$PWD/bin:$PATH
            '';
          };
      });
}
