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

  -- speed up filetype
  { "nathom/filetype.nvim" },

  -- format
  {
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugins.null-ls").setup()
      end,
   },

   -- auto save
  {
    "Pocco81/AutoSave.nvim",
    config = function()
       local autosave = require "autosave"

       autosave.setup {
          enabled = true,
          execution_message = "autosaved at : " .. vim.fn.strftime "%H:%M:%S",
          events = { "InsertLeave", "TextChanged" },
          conditions = {
             exists = true,
             filetype_is_not = {},
             modifiable = true,
          },
          clean_command_line_interval = 2500,
          on_off_commands = true,
          write_all_buffers = false,
       }
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
