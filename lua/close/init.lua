local M = {}

function M.setup()
  local brackets = {
    ["("] = ")",
    ["["] = "]",
    ["{"] = "}",
    ['"'] = '"',
    ["'"] = "'"
  }

  for open, close in pairs(brackets) do
    vim.keymap.set("i", open, function()
      return open .. close .. "<Left>"
    end, { expr = true, noremap = true })
  end
end

return M
