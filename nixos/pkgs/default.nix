(
  self: super: {
    fre = super.callPackage ./fre.nix {};

    # rollback to version 0.14 as 0.20 is all kinds of broken.
    i3status-rust = super.callPackage ./i3status-rust.nix {};
  }
)
