return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "stylua",
      "shellcheck",
      "shfmt",
      -- Python
      "ruff",
      "pyright",
      -- Rust
      -- "rust-analyzer", -- rustaceanvim typically manages this or uses rustup, but good to have
      -- Web
      "vtsls",
      "prettier",
      "eslint-lsp",
      -- Markdown
      "markdownlint",
    },
  },
}

