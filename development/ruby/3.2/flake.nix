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
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        ruby = nixpkgs-ruby.packages.${system}."ruby-3.2.2";
      in {
        devShell = with pkgs;
          mkShell {
            buildInputs = [
              ruby
            ];

            shellHook = ''
              export GEM_HOME="./tmp/gem/ruby"
              export GEM_PATH=$GEM_HOME
              export PATH=$GEM_HOME/bin:$PATH
              export PATH=$PWD/bin:$PATH
            '';
          };
      });
}
