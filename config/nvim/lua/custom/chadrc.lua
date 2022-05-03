local M = {}

local userPlugins = require "custom.plugins"
local pluginConfs = require "custom.plugins.configs"


M.plugins = {
   install = userPlugins,

   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },

   user = {
      nvim_treesitter = pluginConfs.treesitter,
   }
}


M.ui = {
   theme = "onedark",
}

-- nvim-lsp-installer
M.options = {
  tabstop = 4,

  lspconfig = {
    setup_lspconf = "custom.configs.lspconfig",
  }
}



return M
