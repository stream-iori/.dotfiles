local M = {}

local userPlugins = require "custom.plugins"
local pluginConfs = require "custom.plugins.configs"


M.plugins = {
   user = userPlugins,

   override = {
      ["nvim-treesitter/nvim-treesitter"] = pluginConfs.treesitter,
      ["kyazdani42/nvim-tree.lua"] = pluginConfs.nvimtree,
   },

   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },
}


M.ui = {
   theme = "onedark",
}

M.options = {
  user = function()
      vim.opt.number = true
   end,

-- nvim-lsp-installer
  lspconfig = {
    setup_lspconf = "custom.configs.lspconfig",
  }
}



return M
