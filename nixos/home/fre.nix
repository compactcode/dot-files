{ pkgs, ... }:

let fre = (pkgs.callPackage ../pkgs/fre.nix {});

in {
  home.packages = [
    fre
  ];

  programs.zsh.initExtra = ''
    fre_chpwd() {
      ${fre}/bin/fre --add "$(pwd)" --store_name dirs
    }

    # List the contents of the 'dirs' store.
    fre_dirs() {
      ${fre}/bin/fre --sorted --store_name dirs
    }

    # Enable chpwd function hooks.
    typeset -ga chpwd_functions

    # Enable auto storing of pwd when changing directories.
    chpwd_functions+=fre_chpwd

    fre_jump() {
      local search_pattern selected_directory

      search_pattern=$1

      if [[ -n $search_pattern ]]
      then
        # If an argument was provided then autojump.
        selected_directory="$(fre_dirs | grep $search_pattern | head -1)"
      else
        # If no argument was provided then show a selection menu.
        selected_directory="$(fre_dirs | ${pkgs.skim}/bin/sk --no-sort)"
      fi

      if [[ -n $selected_directory ]]
      then
        cd $selected_directory
      fi
    }
  '';

  programs.zsh.shellAliases = {
    j = "fre_jump";
  };
}
