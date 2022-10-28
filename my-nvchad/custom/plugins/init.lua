return {
   ["phaazon/hop.nvim"] = {
      branch = "v1", -- optional but strongly recommended
      config = function()
         -- you can configure Hop the way you like here; see :h hop-config
         require("hop").setup {}
         -- normal mode (easymotion-like)
         vim.api.nvim_set_keymap("n", "<Leader>s", "<cmd>HopChar2<CR>", { noremap = true })
         -- visual mode (easymotion-like)
         vim.api.nvim_set_keymap("v", "<Leader>s", "<cmd>HopChar2<CR>", { noremap = true })
      end,
   },

   -- auto save
   ["pocco81/auto-save.nvim"] = {},

   ["williamboman/nvim-lsp-installer"] = {},
   ["tpope/vim-surround"] = {
      keys = { "c", "d", "S" },
   },

   ["ray-x/go.nvim"] = {
      config = function()
         require("custom.plugins.go").setup()
      end,
   },
}
