let
  unstable = import <nixos-unstable> {};

in (
  self: super: {
    fre = super.callPackage ./fre.nix {};

    # 19.03 skim is missing a lot of improvements.
    skim = unstable.skim;

    # 19.03 alacritty is missing a lot of improvements.
    alacritty = unstable.alacritty;

    # 19.03 bat is missing the base16 theme.
    bat = unstable.bat;
  }
)
