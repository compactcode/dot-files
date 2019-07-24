{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fre
  ];

  # List the recently edited files.
  xdg.dataFile."bin/recently-edited-list" = {
    executable = true;
    text = ''
      #!/bin/sh

      ${pkgs.fre}/bin/fre --sorted --store_name edited --sort_method recent
    '';
  };

  # Add a file to the list of recently edited files.
  xdg.dataFile."bin/recently-edited-add" = {
    executable = true;
    text = ''
      #!/bin/sh

      if [[ -n $1 ]]
      then
        ${pkgs.fre}/bin/fre --add $1 --store_name edited
      fi
    '';
  };

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
