return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "java",
      "bash",
      "html",
      "javascript",
      "json5",
      "lua",
      "c",
      -- rust start
      "rust",
      "ron",
      -- rust end
      --  markdown start
      "markdown",
      "markdown_inline",
      -- markdown end
      -- python start
      "python",
      "ninja",
      "rst",
      -- python end
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "yaml",
      "toml",
    },
  },
}
