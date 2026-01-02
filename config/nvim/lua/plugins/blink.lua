return {
  {
    "saghen/blink.cmp",
    -- 使用预编译的二进制文件，无需本地 cargo 环境
    version = "*",
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
        -- 默认使用 Rust 实现
      },
    },
    opts_extend = { "sources.default" },
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