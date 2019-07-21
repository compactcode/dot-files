{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fre
  ];

  # We use .zshenv so that the commands are available in non interactive shells (vim).
  home.file.".zshenv".text = ''
    # Helper command to record when a file is edited.
    fre_store_edited() {
      if [[ -n $1 ]]
      then
        ${pkgs.fre}/bin/fre --add $1 --store_name edited
      fi
    }

    # Helper to list edited files.
    fre_list_edited() {
      ${pkgs.fre}/bin/fre --sorted --store_name edited
    }
  '';

  programs.zsh.initExtra = ''
    fre_store_pwd() {
      ${pkgs.fre}/bin/fre --add "$(pwd)" --store_name dirs
    }

    fre_list_dirs() {
      ${pkgs.fre}/bin/fre --sorted --store_name dirs
    }

    # Enable chpwd function hooks.
    typeset -ga chpwd_functions

    # Enable chpwd storage hook.
    chpwd_functions+=fre_store_pwd

    fre_jump() {
      local search_pattern selected_directory

      search_pattern=$1

      if [[ -n $search_pattern ]]
      then
        # If an argument was provided then autojump.
        selected_directory="$(fre_list_dirs | grep $search_pattern | head -1)"
      else
        # If no argument was provided then show a selection menu.
        selected_directory="$(fre_list_dirs | ${pkgs.skim}/bin/sk --no-sort)"
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
