return {
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      local attach = opts.on_attach
      opts.on_attach = function(buffer)
        if attach then
          attach(buffer)
        end
        local gs = require("gitsigns")
        local staging = false
        vim.keymap.set({ "n", "x" }, "<leader>ghs", function()
          if staging then
            return
          end
          local first, last = vim.fn.line("."), vim.fn.line(".")
          local mode = vim.fn.mode()
          local visual = mode == "v" or mode == "V" or mode == "\22"
          if visual then
            first, last = math.min(first, vim.fn.line("v")), math.max(last, vim.fn.line("v"))
            vim.cmd.normal({ "\27", bang = true })
          end
          -- stage_hunk toggles to unstage if no unstaged hunk exists. Keep ghs
          -- stage-only; ghu is the explicit unstage entry on both editors.
          for _, hunk in ipairs(gs.get_hunks(buffer) or {}) do
            local start = math.max(1, hunk.added.start)
            local finish = math.max(start, hunk.added.start + hunk.added.count - 1)
            if first <= finish and last >= start then
              staging = true
              gs.stage_hunk(visual and { first, last } or nil, nil, function()
                staging = false
              end)
              return
            end
          end
          vim.notify("No unstaged hunk here", vim.log.levels.INFO)
        end, { buffer = buffer, desc = "Stage Hunk / Selection" })
        -- The old undo_stage_hunk only undid the last stage in this session.
        -- Use the native Git UI to choose staged hunks, including overlapping edits.
        vim.keymap.set("n", "<leader>ghu", function()
          Snacks.lazygit({ cwd = LazyVim.root.git(), args = { "status" } })
        end, { buffer = buffer, desc = "Unstage Changes (Select in Lazygit)" })
        vim.keymap.set("n", "<leader>ghd", function()
          gs.diffthis("HEAD")
        end, { buffer = buffer, desc = "Diff File Against HEAD" })
      end
    end,
  },
}
