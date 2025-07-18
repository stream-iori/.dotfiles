return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      snippets = {
        expand = function(snippet, _)
          return LazyVim.cmp.expand(snippet)
        end,
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
      signature = { enabled = true },
      sources = {
        compat = {},
        default = { "lsp", "path", "snippets", "buffer" },
      },
      cmdline = {
        sources = {},
      },
      keymap = {
        preset = "enter",
        ["<C-y>"] = { "select_and_accept" },
      },
      fuzzy = {
        implementation = "lua",
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
