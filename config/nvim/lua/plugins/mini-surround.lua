-- Mini Surround Configuration
-- 
-- Mappings (simulating nvim-surround/vim-surround behavior):
--
-- Normal Mode:
--   ys{motion}{char}  -> Add surround (e.g., ysiw" -> "word")
--   yss{char}         -> Add surround to current line
--   ds{char}          -> Delete surround (e.g., ds" -> word)
--   cs{target}{repl}  -> Change surround (e.g., cs"' -> 'word')
--
-- Visual Mode:
--   S{char}           -> Add surround to selection
--
-- Supported Surroundings:
--   Any single character: ", ', `, (, [, {, <, etc.
--   t                 : HTML tags (prompts for tag)
--   f                 : Function call (prompts for function name)
--
return {
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "ys",
        delete = "ds",
        replace = "cs",
        find = "",
        find_left = "",
        highlight = "",
        update_n_lines = "",
        suffix_last = "",
        suffix_next = "",
      },
      search_method = "cover_or_next",
    },
    keys = {
      -- Visual mode 'S' mapping
      { "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], mode = "x", desc = "Add Surrounding" },
      -- 'yss' shortcut for surrounding the current line
      { "yss", "ys_", remap = true, desc = "Surround Line" },
    },
  },
}
