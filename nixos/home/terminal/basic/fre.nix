{ pkgs, config, ... }:

{
  # List recently edited files.
  xdg.dataFile."bin/recently-edited-list" = {
    executable = true;
    text = ''
      #!/bin/sh

      ${pkgs.fre}/bin/fre --sorted --store_name edited --sort_method recent | xargs realpath -q -s
    '';
  };

  # Add a file to the list of recently edited files.
  xdg.dataFile."bin/recently-edited-add" = {
    executable = true;
    text = ''
      #!/bin/sh

      if [ -n "$1" ]; then
        ${pkgs.fre}/bin/fre --add $1 --store_name edited
      fi
    '';
  };

  # List frequently used directories.
  xdg.dataFile."bin/frequent-directory-list" = {
    executable = true;
    text = ''
      #!/bin/sh

      ${pkgs.fre}/bin/fre --sorted --store_name dirs
    '';
  };

  # Add a directory to the list of frequently used directories.
  xdg.dataFile."bin/frequent-directory-add" = {
    executable = true;
    text = ''
      #!/bin/sh

      if [ -n "$1" ]; then
        ${pkgs.fre}/bin/fre --add $1 --store_name dirs
      fi
    '';
  };

  programs.zsh.initExtra = ''
    # Enable chpwd function hooks.
    typeset -ga chpwd_functions

    _fre_chpwd_function() {
      ${config.xdg.dataHome}/bin/frequent-directory-add "$(pwd)"
    }

    # Enable chpwd storage hook.
    chpwd_functions+=_fre_chpwd_function

    # Navigate to a recently used directory.
    jump() {
      if [ -n "$1" ]; then
        # If an argument was provided then autojump.
        SELECTED_DIRECTORY="$(${config.xdg.dataHome}/bin/frequent-directory-list | grep $1 | head -1)"
      else
        # If no argument was provided then show a selection menu.
        SELECTED_DIRECTORY="$(${config.xdg.dataHome}/bin/frequent-directory-list | ${pkgs.skim}/bin/sk --no-sort)"
      fi

      if [ -n "$SELECTED_DIRECTORY" ]; then
        cd $SELECTED_DIRECTORY
      fi
    }
  '';

  programs.zsh.shellAliases = {
    j = "jump";
  };
}
