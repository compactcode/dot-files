{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>af";
        action = "<cmd>lua require(\"conform\").format()<cr>";
        options = {desc = "format code";};
      }
    ];

    # formatting
    plugins.conform-nvim = {
      enable = true;
      # globally installed formatters
      formatters = {
        alejandra = {
          command = "${lib.getExe pkgs.alejandra}";
        };
        jq = {
          command = "${lib.getExe pkgs.jq}";
        };
        prettierd = {
          command = "${lib.getExe pkgs.prettierd}";
        };
        shfmt = {
          command = "${lib.getExe pkgs.shfmt}";
        };
      };

      # enabled formatters
      formattersByFt = {
        json = ["jq"];
        nix = ["alejandra"];
        sh = ["shfmt"];
        yaml = ["prettierd"];
      };
    };
  };
}
