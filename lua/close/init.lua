local M = {}

function M.setup()
  local pairs = {
    ["("] = ")",
    ["["] = "]",
    ["{"] = "}",
    ['"'] = '"',
    ["'"] = "'"
  }

  for open, close in pairs(pairs) do
    vim.keymap.set("i", open, function()
      return open .. close .. "<Left>"
    end, { expr = true, noremap = true })
  end
end

return M
