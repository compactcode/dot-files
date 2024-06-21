{
  lib,
  pkgs,
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

      # custom function allowing auto formatting to be disabled
      formatOnSave = ''
        function(bufnr)
          if vim.g.disable_autoformat then
            return
          end
          return { lsp_format = "fallback" }
        end
      '';

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

    # custom command to disable auto formatting
    userCommands = {
      "ConformToggle".command.__raw = ''
        function()
          if vim.g.disable_autoformat then
            vim.g.disable_autoformat = false
          else
            vim.g.disable_autoformat = true
          end
        end
      '';
    };
  };
}