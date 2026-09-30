return {
  {
    "folke/flash.nvim",
    opts = {
      -- Keep Vim's line-local f/F/t/T and repeat behavior on both editors.
      modes = { char = { enabled = false } },
    },
    keys = {
      { "S", mode = { "n", "x", "o" }, false },
      { "r", mode = "o", false },
      { "R", mode = { "o", "x" }, false },
      { "<C-Space>", mode = { "n", "x", "o" }, false },
      {
        "<leader>jS",
        function()
          require("flash").treesitter()
        end,
        mode = { "n", "x", "o" },
        desc = "Flash Treesitter (Neovim)",
      },
      {
        "<leader>jr",
        function()
          require("flash").remote()
        end,
        mode = "o",
        desc = "Remote Flash (Neovim)",
      },
      {
        "<leader>jR",
        function()
          require("flash").treesitter_search()
        end,
        mode = { "o", "x" },
        desc = "Flash Treesitter Search (Neovim)",
      },
    },
  },
}
