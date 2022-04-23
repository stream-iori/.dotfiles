local M = {}

local userPlugins = require "custom.plugins"
local pluginConfs = require "custom.plugins.configs"


M.plugins = {
   -- enable/disable plugins (false for disable)
   status = {
      bufferline = false, -- manage and preview opened buffers
   },

   install = userPlugins,

   default_plugin_remove = {
       "akinsho/bufferline.nvim",
   },

  default_plugin_config_replace = {
      nvim_treesitter = pluginConfs.treesitter,
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
