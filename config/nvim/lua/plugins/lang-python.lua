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
            },
          },
          keys = {
            {
              "<leader>co",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
          -- Use standard on_attach instead of the deprecated LazyVim wrapper
          on_attach = function(client, _)
            client.server_capabilities.hoverProvider = false
          end,
        },
        pyright = {
          enabled = true,
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          runner = "pytest",
          python = function()
            -- Locate the virtual environment
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
    dependencies = {
      "neovim/nvim-lspconfig",
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    lazy = false,
    opts = {},
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
  },
}