-- Match IDE Extend/Shrink Selection without label prompts or text changes.
local M = {}
local history = {}

local function current_range()
  local start = vim.fn.getpos("v")
  local finish = vim.api.nvim_win_get_cursor(0)
  local a, b = { start[2], start[3] - 1 }, { finish[1], finish[2] }
  if a[1] > b[1] or (a[1] == b[1] and a[2] > b[2]) then
    a, b = b, a
  end
  return { a[1], a[2], b[1], b[2] }
end

local function node_range(node)
  local sr, sc, er, ec = node:range()
  if ec == 0 and er > sr then
    er = er - 1
    ec = #vim.api.nvim_buf_get_lines(0, er, er + 1, false)[1]
  end
  local line = vim.api.nvim_buf_get_lines(0, er, er + 1, false)[1]
  local last = ec > 0 and vim.fn.byteidx(line, vim.fn.charidx(line, ec - 1)) or 0
  return { sr + 1, sc, er + 1, math.max(0, last) }
end

local function select(range)
  if vim.fn.mode():match("^[vV\22]") then
    vim.cmd.normal({ "\27", bang = true })
  end
  vim.api.nvim_win_set_cursor(0, { range[1], range[2] })
  vim.cmd.normal({ "v", bang = true })
  vim.api.nvim_win_set_cursor(0, { range[3], range[4] })
end

function M.expand()
  local ok, node = pcall(vim.treesitter.get_node)
  if not ok or not node then
    if not vim.fn.mode():match("^[vV\22]") then
      vim.cmd.normal({ "viw", bang = true })
      history[vim.api.nvim_get_current_buf()] = { current_range() }
    else
      vim.notify("No syntax tree to expand this selection", vim.log.levels.INFO)
    end
    return
  end
  local visual = vim.fn.mode():match("^[vV\22]")
  local previous = visual and current_range() or nil
  local stack = history[vim.api.nvim_get_current_buf()] or {}
  if not previous or not vim.deep_equal(stack[#stack], previous) then
    stack = previous and { previous } or {}
  end
  while node do
    local range = node_range(node)
    if
      not previous
      or (
        (range[1] < previous[1] or (range[1] == previous[1] and range[2] <= previous[2]))
        and (range[3] > previous[3] or (range[3] == previous[3] and range[4] >= previous[4]))
        and not vim.deep_equal(range, previous)
      )
    then
      stack[#stack + 1] = range
      history[vim.api.nvim_get_current_buf()] = stack
      select(range)
      return
    end
    node = node:parent()
  end
end

function M.shrink()
  local stack = history[vim.api.nvim_get_current_buf()]
  if stack and vim.deep_equal(stack[#stack], current_range()) then
    if #stack > 1 then
      table.remove(stack)
      select(stack[#stack])
    else
      vim.cmd.normal({ "\27", bang = true })
      history[vim.api.nvim_get_current_buf()] = nil
    end
  end
end

vim.api.nvim_create_autocmd("BufWipeout", {
  callback = function(event)
    history[event.buf] = nil
  end,
})

return M
