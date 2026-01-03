return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          keys = {
            { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C++)" },
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "opt/build/meson.build",
              "build.ninja",
              "compile_commands.json",
              "compile_flags.txt"
            )(fname) or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
          end,
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      },
    },
    -- 标准 Neovim API: LspAttach
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user-c-lsp", { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.name == "clangd" then
            -- C 特定的快捷键
            vim.keymap.set(
              "n",
              "<leader>ch",
              "<cmd>ClangdSwitchSourceHeader<cr>",
              { buffer = event.buf, desc = "Switch Source/Header" }
            )
          end
        end,
      })
    end,
  },

  -- 确保 Mason 安装了 clangd
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
      },
    },
  },
}
