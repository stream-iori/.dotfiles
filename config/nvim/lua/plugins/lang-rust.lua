return {
  {
    "mrcjkb/rustaceanvim",
    opts = {
      dap = {
        adapter = false,
        configuration = false,
        autoload_configurations = false,
      },
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>cR", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Rust Code Action", buffer = bufnr })
        end,
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
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
              exclude = {
                ".direnv",
                ".git",
                ".jj",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
              },
              watcher = "client",
            },
          },
        },
      },
    },
    config = function(_, opts)
      opts.dap = {
        adapter = false,
        configuration = false,
        autoload_configurations = false,
      }
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts)
      if vim.fn.executable("rust-analyzer") == 0 then
        LazyVim.error("rust-analyzer not found in PATH", { title = "rustaceanvim" })
      end
    end,
  },
}
