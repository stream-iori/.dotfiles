local M = {}

local userPlugins = require "custom.plugins" -- path to table

M.plugins = {
   install = userPlugins,

   default_plugin_remove = {
       "akinsho/bufferline.nvim",
   },

   -- enable/disable plugins (false for disable)
   status = {
      bufferline = false, -- manage and preview opened buffers
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

-- nvim-lsp-installer
M.options = {
  tabstop = 4,

  lspconfig = {
    setup_lspconf = "custom.configs.lspconfig",
  }
}



return M
