return {
   { "williamboman/nvim-lsp-installer" },

   {
    "karb94/neoscroll.nvim",
     opt = true,
     config = function()
        require("neoscroll").setup()
     end,

     -- lazy loading
     setup = function()
       require("core.utils").packer_lazy_load "neoscroll.nvim"
     end,
  },

   { "tpope/vim-surround",
      keys = {"c", "d", "S"},
   },

   {
    'phaazon/hop.nvim',
     branch = 'v1', -- optional but strongly recommended
     config = function()
     -- you can configure Hop the way you like here; see :h hop-config
        require'hop'.setup{}
     -- normal mode (easymotion-like)
        vim.api.nvim_set_keymap("n", "<Leader>s", "<cmd>HopChar2<CR>", {noremap=true})
     -- visual mode (easymotion-like)
        vim.api.nvim_set_keymap("v", "<Leader>s", "<cmd>HopChar2<CR>", {noremap=true})
     end
   },

   {
     "ray-x/go.nvim"
   },
}
