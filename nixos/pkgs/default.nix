(
  self: super: {
    # rust crate for usage directory/file usage tracking.
    fre = super.callPackage ./fre.nix {};

    # rollback to version 0.14 as 0.20 is all kinds of broken.
    i3status-rust = super.callPackage ./i3status-rust.nix {};

    # discord will not run unless on the latest version at all times.
    discord = super.callPackage ./discord/default.nix {};
  }
)
