{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim = {
    # formatting
    plugins.conform-nvim = {
      enable = true;

      settings = {
        # custom function allowing auto formatting to be disabled
        format_on_save = ''
          function(bufnr)
            if vim.g.disable_autoformat then
              return
            end
            return { timeout_ms = 1500, lsp_format = "fallback" }
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
        formatters_by_ft = {
          eruby = ["htmlbeautifier"];
          html = ["prettierd"];
          json = ["jq"];
          nix = ["alejandra"];
          ruby = ["rubocop"];
          sh = ["shfmt"];
          yaml = ["prettierd"];
        };
      };

      # delay loading until requested or editing
      lazyLoad.settings = {
        cmd = "ConformInfo";
        event = "InsertEnter";
        keys = [
          {
            __unkeyed-1 = "<leader>af";
            __unkeyed-2 = "<cmd>lua require(\"conform\").format()<cr>";
            desc = "format code";
          }
        ];
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
