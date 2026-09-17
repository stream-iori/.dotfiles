return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({
            action = "show",
            source = "filesystem",
            position = "left",
            dir = LazyVim.root(),
            reveal = true,
          })
        end,
        desc = "Reveal Current File in NeoTree",
      },
    },
    opts = {
      window = {
        mappings = {
          ["v"] = "open_vsplit",
          ["s"] = "open_split",
          ["P"] = { "toggle_preview", config = { use_float = true } },
          -- 确保其他常用键位也正常
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
    },
  },
}
