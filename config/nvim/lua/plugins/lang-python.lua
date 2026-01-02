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
        },
        pyright = {
          enabled = true,
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
    -- 使用 init 函数设置原生的 LspAttach 监听器
    -- 这会在插件加载前注册，确保能捕获到第一个 LSP 连接事件
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user-python-lsp", { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client then
            return
          end

          -- 针对 Ruff 的特定配置
          if client.name == "ruff" then
            -- 1. 禁用 Hover (让 Pyright 处理)
            client.server_capabilities.hoverProvider = false

            -- 2. 绑定 Organize Imports 快捷键 (原生方式)
            -- 使用 LazyVim 提供的 helper 来简化 "Code Action" 的调用，
            -- 但绑定的时机和方式是原生的
            vim.keymap.set("n", "<leader>co", function()
              LazyVim.lsp.action["source.organizeImports"]()
            end, { buffer = event.buf, desc = "Organize Imports" })
          end
        end,
      })
    end,
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
