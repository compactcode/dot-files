{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

  outputs = { self, nixpkgs }: {

    nixosConfigurations.medusa = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        (import ./system.nix)
      ];
    };

  };
}
