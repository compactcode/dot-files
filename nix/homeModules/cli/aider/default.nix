{
  config,
  pkgs,
  ...
}: {
  home = {
    file.".aider.conf.yml".source = (pkgs.formats.yaml {}).generate "aider-config" {
      # output style
      user-input-color = "#${config.lib.stylix.colors.base0B}";
      tool-output-color = "#${config.lib.stylix.colors.base05}";
      tool-error-color = "#${config.lib.stylix.colors.base08}";
      tool-warning-color = "#${config.lib.stylix.colors.base0A}";
      assistant-output-color = "#${config.lib.stylix.colors.base0D}";
      completion-menu-color = "#${config.lib.stylix.colors.base05}";
      completion-menu-bg-color = "#${config.lib.stylix.colors.base00}";
      completion-menu-current-color = "#${config.lib.stylix.colors.base00}";
      completion-menu-current-bg-color = "#${config.lib.stylix.colors.base0D}";

      # markdown style
      code-theme = "github-dark";
    };

    packages = [
      # ai assistant
      pkgs.aider-chat
    ];
  };
}
