{ pkgs, ... }:

{
  home.packages = [
    (pkgs.callPackage ../pkgs/fre.nix {})
  ];

  programs.zsh.initExtra = ''
    # Record the current directory in the 'dirs' store.
    fre_chpwd() {
      fre --add "$(pwd)" --store_name dirs
    }

    # Enable auto-execution of chpwd functions.
    typeset -ga chpwd_functions

    # Enable auto recording.
    chpwd_functions+=fre_chpwd
  '';

  programs.zsh.shellAliases = {
    j = ''
      cd "$(fre --sorted --store_name dirs | sk --no-sort)"
    '';
  };
}
