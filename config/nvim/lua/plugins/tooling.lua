local markdownlint_config = vim.fn.stdpath("config") .. "/.markdownlint-cli2.yaml"

local function clang_format_command()
  local executable = vim.fn.exepath("clang-format")
  if executable ~= "" then
    return executable
  end
  local result = vim.fn.systemlist({ "xcrun", "--find", "clang-format" })
  return vim.v.shell_error == 0 and result[1] or "clang-format"
end

local function eslint_root(bufnr, on_dir)
  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == "" then
    return
  end

  local eslint_configs = {
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "eslint.config.mts",
    "eslint.config.cts",
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.json",
    ".eslintrc.yaml",
    ".eslintrc.yml",
  }
  local config = vim.fs.find(eslint_configs, { path = vim.fs.dirname(name), upward = true })[1]
  if config then
    on_dir(vim.fs.dirname(config))
    return
  end

  local dir = vim.fs.dirname(name)
  while dir do
    local package_json = vim.fs.joinpath(dir, "package.json")
    if vim.fn.filereadable(package_json) == 1 then
      local ok, package = pcall(vim.json.decode, table.concat(vim.fn.readfile(package_json), "\n"))
      if ok and type(package) == "table" and package.eslintConfig then
        on_dir(dir)
        return
      end
    end
    local parent = vim.fs.dirname(dir)
    if parent == dir then
      break
    end
    dir = parent
  end
end

return {
  { "mfussenegger/nvim-dap", enabled = false },
  { "mfussenegger/nvim-dap-python", enabled = false },
  { "rcarriga/nvim-dap-ui", enabled = false },
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      local excluded = {
        codelldb = true,
        debugpy = true,
        ["js-debug-adapter"] = true,
      }
      local required = {
        "bash-language-server",
        "markdown-toc",
        "markdownlint-cli2",
        "prettier",
        "ruff",
        "shellcheck",
        "shfmt",
        "stylua",
      }
      local ensure_installed = {}
      local seen = {}

      for _, tool in ipairs(opts.ensure_installed or {}) do
        if not excluded[tool] and not seen[tool] then
          seen[tool] = true
          ensure_installed[#ensure_installed + 1] = tool
        end
      end
      for _, tool in ipairs(required) do
        if not seen[tool] then
          seen[tool] = true
          ensure_installed[#ensure_installed + 1] = tool
        end
      end
      table.sort(ensure_installed)
      opts.ensure_installed = ensure_installed
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        c = { "clang_format" },
        cpp = { "clang_format" },
        objc = { "clang_format" },
        objcpp = { "clang_format" },
        cuda = { "clang_format" },
        python = { "ruff_format" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        rust = { "rustfmt" },
      })
      opts.formatters = opts.formatters or {}
      opts.formatters.clang_format =
        vim.tbl_deep_extend("force", opts.formatters.clang_format or {}, { command = clang_format_command })
      opts.formatters["markdownlint-cli2"] = vim.tbl_deep_extend(
        "force",
        opts.formatters["markdownlint-cli2"] or {},
        { prepend_args = { "--config", markdownlint_config } }
      )
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.sh = { "shellcheck" }
      opts.linters_by_ft.bash = { "shellcheck" }
      opts.linters = opts.linters or {}
      opts.linters["markdownlint-cli2"] = vim.tbl_deep_extend(
        "force",
        opts.linters["markdownlint-cli2"] or {},
        { prepend_args = { "--config", markdownlint_config } }
      )
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          root_dir = eslint_root,
          settings = {
            workingDirectory = { mode = "auto" },
          },
        },
      },
    },
  },
}
