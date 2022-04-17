local M = {}

local userPlugins = require "custom.plugins" -- path to table

M.plugins = {
   install = userPlugins,

   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },
}


M.ui = {
   theme = "onedark",
}

-- nvim-lsp-installer
M.options = {
  lspconfig = {
    setup_lspconf = "custom.configs.lspconfig",
  }
}



return M
