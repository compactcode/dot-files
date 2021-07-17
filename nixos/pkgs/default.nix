(
  self: super: {
    # rust crate for usage directory/file usage tracking.
    fre = super.callPackage ./fre.nix {};

    # discord will not run unless on the latest version at all times.
    # discord = super.callPackage ./discord/default.nix {};
  }
)
