local M = {}

M.treesitter = {
   ensure_installed = {
      "go",
      "lua",
      "vim",
      "java",
      "html",
      "css",
   },
}

M.nvimtree = {
   git = {
      enable = true,
   },
   view = {
      side = "left",
      width = 30,
   },
}

return M
