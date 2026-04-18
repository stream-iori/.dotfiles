return {
  -- 换成这个更简单、稳定的 parinfer 插件，不需要手动编译
  {
    "gpanders/nvim-parinfer",
    ft = { "clojure", "scheme", "lisp", "racket" },
  },

  -- 额外配置 Conjure
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "python" },
    opts = function(_, opts)
      return opts
    end,
  },

  -- 自动安装 LSP
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "clojure-lsp" })
    end,
  },
}
