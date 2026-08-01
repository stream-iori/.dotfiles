return {
  {
    "saghen/blink.cmp",
    opts = {
      signature = { enabled = true },
      cmdline = {
        sources = {},
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        ["*"] = function(_, opts)
          opts.capabilities = require("blink.cmp").get_lsp_capabilities()
        end,
      },
    },
  },
}
