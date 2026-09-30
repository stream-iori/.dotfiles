local function reveal()
  require("neo-tree.command").execute({
    action = "focus",
    source = "filesystem",
    position = "left",
    dir = LazyVim.root(),
    reveal = true,
  })
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>e",
        reveal,
        desc = "Reveal Current File in NeoTree",
      },
      { "<leader>fe", reveal, desc = "Reveal Current File in NeoTree" },
      { "<leader>gp", reveal, desc = "Reveal Current File in NeoTree" },
    },
    opts = {
      window = {
        mappings = {
          ["v"] = "open_vsplit",
          ["s"] = "open_split",
          ["P"] = { "toggle_preview", config = { use_float = true } },
          ["A"] = "add_directory",
          ["<D-x>"] = "cut_to_clipboard",
          ["gr"] = "refresh",
          ["l"] = "open",
          -- Match IdeaVim NERDTree: select the parent, then collapse it.
          ["h"] = function(state)
            local node = state.tree:get_node()
            local parent = node and node:get_parent_id()
            if parent then
              local renderer = require("neo-tree.ui.renderer")
              state.tree:get_node(parent):collapse()
              renderer.redraw(state)
              renderer.focus_node(state, parent)
            end
          end,
        },
      },
    },
  },
}
