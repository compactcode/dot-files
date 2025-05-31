{pkgs, ...}: {
  home = {
    file.".aider.conf.yml".text = ''
      # output style (catppuccin mocha)
      user-input-color: "#a6e3a1" # green
      tool-output-color: "#cdd6f4" # text
      tool-error-color: "#f38ba8" # red
      tool-warning-color: "#f9e2af" # yellow
      assistant-output-color: "#89b4fa" # blue
      completion-menu-color: "#cdd6f4" # text
      completion-menu-bg-color: "#1e1e2e" # base
      completion-menu-current-color: "#1e1e2e" # base (bg)
      completion-menu-current-bg-color: "#89b4fa" # blue

      # markdown
      code-theme: github-dark
    '';

    packages = [
      # ai assistant
      pkgs.aider-chat
    ];
  };
}
