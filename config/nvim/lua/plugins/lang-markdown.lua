return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      -- 确保 linters 表存在
      opts.linters = opts.linters or {}
      opts.linters.markdownlint = opts.linters.markdownlint or {}
      -- 拦截 parser 结果。
    end,
    config = function(_, opts)
      local lint = require("lint")
      local markdownlint = lint.linters.markdownlint
      -- 保存原始的 parser (如果是函数)
      -- 注意：markdownlint.parser 可能是一个 require 调用后的结果，我们需要小心处理
      -- nvim-lint 的 parser 通常是一个函数
      local original_parser = markdownlint.parser
      markdownlint.parser = function(output, bufnr)
        -- 调用原始 parser 解析输出
        local diagnostics = original_parser(output, bufnr, _)
        -- 过滤列表
        local ignore_codes = {
          ["MD013"] = true, -- Line length
          ["MD033"] = true, -- Inline HTML
          ["MD041"] = true, -- First line h1
          ["MD025"] = true, -- Multiple h1
        }
        local filtered = {}
        for _, d in ipairs(diagnostics) do
          -- diagnostic.code 通常包含 "MD013" 这样的字符串，或者 message 里包含
          -- markdownlint 的 code 通常放在 d.code 或 d.source 里
          -- 我们检查 code
          if not (d.code and ignore_codes[d.code]) then
            table.insert(filtered, d)
          end
        end
        return filtered
      end
      -- 初始化 nvim-lint
      require("lint").linters_by_ft = opts.linters_by_ft
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
      -- 开启 LaTeX 支持
      latex = { enabled = true },
    },
    ft = { "markdown", "norg", "rmd", "org" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline", "latex" })
      end
    end,
  },
}
