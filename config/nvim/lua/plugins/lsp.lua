return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        -- 多行诊断不画下划线，保留虚拟文本和侧栏标记。
        underline = false,
      },
    },
  },
}
