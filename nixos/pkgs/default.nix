(
  self: super: {
    fre = super.callPackage ./fre.nix {};
    skim = super.callPackage ./skim.nix {};
  }
)
