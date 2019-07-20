{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zsh-prezto
  ];

  programs.zsh = {
    enable = true;

    initExtra = ''
      zstyle ':prezto:load' pmodule \
        'environment' \
        'editor' \
        'directory' \
        'history' \
        'prompt'

      zstyle ':prezto:module:prompt' theme 'pure'

      source ${pkgs.zsh-prezto}/init.zsh
    '';

    sessionVariables = {
      EDITOR = "vim";
    };

    shellAliases = {
      # ls replacement
      l  = "${pkgs.exa}/bin/exa -la";
      # ls tree view
      lt = "${pkgs.exa}/bin/exa -l --tree";
      # cat replacement
      b  = "${pkgs.bat}/bin/bat";
      # shortcut
      md = "mkdir -p";
      # Shortcut
      v  = "vim";
    };
  };
}
