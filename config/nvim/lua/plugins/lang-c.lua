return {
  -- 确保 Mason 安装了 codelldb (clangd 由 Extra 安装)
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "codelldb",
      },
    },
  },
}