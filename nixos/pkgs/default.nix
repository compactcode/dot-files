(
  self: super: {
    fre = super.callPackage ./fre.nix {};

    # 1.9.2 ranger doesn't handle padding on the terminal emulator window.
    ranger = super.callPackage ./ranger.nix {};
  }
)
