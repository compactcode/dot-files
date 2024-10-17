{
  inputs = {
    _1password-shell-plugins = {
      url = "github:1Password/shell-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flakelight = {
      url = "github:nix-community/flakelight";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix = {
      url = "github:danth/stylix";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = {flakelight, ...} @ inputs:
    flakelight.lib.mkFlake ./. {
      inherit inputs;
      nixpkgs.config = {allowUnfree = true;};
      withOverlays = [
        (final: prev: {
          # waiting for https://github.com/NixOS/nixpkgs/pull/348887
          cliphist = prev.cliphist.overrideAttrs (_old: {
            src = final.fetchFromGitHub {
              owner = "sentriz";
              repo = "cliphist";
              rev = "c49dcd26168f704324d90d23b9381f39c30572bd";
              sha256 = "sha256-2mn55DeF8Yxq5jwQAjAcvZAwAg+pZ4BkEitP6S2N0HY=";
            };
            vendorHash = "sha256-M5n7/QWQ5POWE4hSCMa0+GOVhEDCOILYqkSYIGoy/l0=";
          });
        })
      ];
    };
}
