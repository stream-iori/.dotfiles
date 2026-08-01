return {
  {
    "nvim-neo-tree/neo-tree.nvim",
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
