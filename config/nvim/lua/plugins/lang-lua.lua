return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.compat",
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                -- ignore diagnostics globals variable
                globals = { "diagnostics" },
              },
            },
          },
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
      },
    },
  },
}