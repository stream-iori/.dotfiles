return {
  "neovim/nvim-lspconfig",
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
      --python start
      pyright = {
        enabled = true,
      },
      ruff = {
        enabled = true,
      },
      --python end
    },
  },
}
