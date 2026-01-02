return {
  -- Crates.nvim for Cargo.toml dependency management
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },

  -- Rustaceanvim for LSP
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Ensure we are using version 5
    lazy = false, -- This plugin is already lazy
    init = function()
      -- 使用原生 LspAttach 统一管理 Rust 相关的 LSP 行为
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user-rust-lsp", { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- rustaceanvim 启动的 server 名字通常是 'rust-analyzer'
          if client and client.name == "rust-analyzer" then
            -- 绑定 Code Action 到 <leader>cR
            vim.keymap.set("n", "<leader>cR", function()
              vim.cmd.RustLsp("codeAction")
            end, { buffer = event.buf, desc = "Code Action (Rust)" })
          end
        end,
      })
    end,
    opts = {
      server = {
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Use clippy for diagnostics
            checkOnSave = true,
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            files = {
              excludeDirs = {
                ".direnv",
                ".git",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
              },
            },
          },
        },
      },
    },
  },

  -- Taplo for TOML support (Cargo.toml)
  {
    "tamasfe/taplo",
    keys = {
      {
        "K",
        function()
          if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
            require("crates").show_popup()
          else
            vim.lsp.buf.hover()
          end
        end,
        desc = "Show Crate Documentation",
      },
    },
  },

  -- Ensure Neotest is configured for Rust
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {},
      },
    },
  },
}

