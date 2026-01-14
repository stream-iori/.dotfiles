return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
              lint = {
                ignore = { "E402" },
              },
            },
          },
          on_attach = function(client)
            client.server_capabilities.hoverProvider = false
          end,
          keys = {
            {
              "<leader>co",
              function()
                LazyVim.lsp.action["source.organizeImports"]()
              end,
              desc = "Organize Imports",
            },
          },
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                diagnosticSeverityOverrides = {
                  reportRedeclaration = "none",
                  reportAttributeAccessIssue = "none",
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      -- Locate debugpy from mason
      local path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)

      -- Custom launch configuration to prefer project .venv
      table.insert(require("dap").configurations.python, {
        type = "python",
        request = "launch",
        name = "Launch file (Prefer .venv)",
        program = "${file}",
        pythonPath = function()
          local venv = os.getenv("VIRTUAL_ENV")
          if venv then
            return venv .. "/bin/python"
          end
          local cwd = vim.fn.getcwd()
          for _, folder in ipairs({ ".venv", "venv" }) do
            local venv_python = cwd .. "/" .. folder .. "/bin/python"
            if vim.fn.executable(venv_python) == 1 then
              return venv_python
            end
          end
          return "python"
        end,
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-neotest/nvim-nio",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          runner = "pytest",
          python = function()
            local venv = os.getenv("VIRTUAL_ENV")
            if venv then
              return venv .. "/bin/python"
            end
            local cwd = vim.fn.getcwd()
            local possible_venvs = { ".venv", "venv" }
            for _, name in ipairs(possible_venvs) do
              local path = cwd .. "/" .. name .. "/bin/python"
              if vim.fn.executable(path) == 1 then
                return path
              end
            end
            return "python"
          end,
        },
      },
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
  },
}