{config, ...}: {
  programs = {
    # terminal
    kitty = {
      enable = true;

      settings = {
        # allow controlling kitty from scripts
        allow_remote_control = "yes";
        # allow using the alt key
        macos_option_as_alt = "both";
      };

      keybindings = {
        "alt+e" = "launch --type=overlay kitty @ focus-tab --match title:^editor$";
        "alt+g" = "launch --type=overlay kitty @ focus-tab --match title:^git$";
        "alt+l" = "launch --type=overlay kitty @ focus-tab --match title:^logs$";
        "alt+p" = "launch --type=overlay kitty @ focus-tab --match title:^processes$";
        "alt+s" = "launch --type=overlay kitty @ focus-tab --match title:^shell$";
      };
    };
  };

  home = {
    shellAliases = {
      ko = "${config.xdg.configFile."kitty/scripts/focus-or-open.sh".source}";
    };
  };

  xdg.configFile."kitty/session-basic.conf" = {
    text = ''
      new_tab editor
      launch --hold nvim

      new_tab shell
      launch zsh

      new_tab git
      launch lazygit
    '';
  };

  xdg.configFile."kitty/session-devenv.conf" = {
    text = ''
      new_tab editor
      launch --hold zsh -c "eval $(direnv export bash) && nvim"

      new_tab shell
      launch zsh

      new_tab processes
      launch --hold zsh -c "eval $(direnv export bash) && devenv up"

      new_tab git
      launch --hold zsh -c "eval $(direnv export bash) && lazygit"

      new_tab logs
      launch zsh
    '';
  };

  xdg.configFile."kitty/scripts/focus-or-open.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      TAB_TITLE=$1
      shift

      # check if a tab with the given title already exists
      if kitty @ ls | jq -e --arg title "$TAB_TITLE" '.[] | .tabs[] | select(.title == $title)' > /dev/null; then
        kitty @ focus-tab --match "title:$TAB_TITLE"
      else
        if [ $# -gt 0 ]; then
          # create tab with given command
          kitty @ launch --type=tab --tab-title "$TAB_TITLE" --cwd=current "$@"
        else
          # create defaut tab
          kitty @ launch --type=tab --tab-title "$TAB_TITLE" --cwd=current
        fi
      fi
    '';
  };

  stylix = {
    targets = {
      kitty.enable = true;
    };
  };
}
