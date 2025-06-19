{...}: {
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

  stylix = {
    targets = {
      kitty.enable = true;
    };
  };
}
