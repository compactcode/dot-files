{...}: {
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>go";
        action = "<cmd>lua require(\"gitlinker\").get_buf_range_url(\"n\", {action_callback = require(\"gitlinker.actions\").open_in_browser})<cr>";
        mode = ["n"];
        options = {desc = "open permalink url to current line";};
      }
      {
        key = "<leader>go";
        action = "<cmd>lua require(\"gitlinker\").get_buf_range_url(\"v\", {action_callback = require(\"gitlinker.actions\").open_in_browser})<cr>";
        mode = ["v"];
        options = {desc = "open permalink url to current lines";};
      }
      {
        key = "<leader>gy";
        action = "<cmd>lua require(\"gitlinker\").get_buf_range_url(\"n\")<cr>";
        mode = ["n"];
        options = {desc = "copy permalink url to current line";};
      }
      {
        key = "<leader>gy";
        action = "<cmd>lua require(\"gitlinker\").get_buf_range_url(\"v\")<cr>";
        mode = ["v"];
        options = {desc = "copy permalink url to current lines";};
      }
    ];

    # git permalinks
    plugins.gitlinker.enable = true;
  };
}
