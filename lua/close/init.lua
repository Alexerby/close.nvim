local M = {}

-- Table of bracket pairs
local brackets = {
    ["("] = ")",
    ["["] = "]",
    ["{"] = "}",
    ['"'] = '"',
    ["'"] = "'",
    ["<"] = ">"
}

-- Set insert mode mappings to auto-close brackets
local function set_autoclose_mappings()
    for open, close in pairs(brackets) do
        vim.keymap.set("i", open, function()
            return open .. close .. "<Left>"
        end, { expr = true, noremap = true })
    end
end

-- Handle backspace between matching brackets
local function set_backspace_mapping()
    vim.keymap.set("i", "<BS>", function()
        local col = vim.fn.col(".")
        if col == 1 then
            return "<BS>"
        end

        local line = vim.fn.getline(".")
        local prev_char = line:sub(col - 1, col - 1)
        local next_char = line:sub(col, col)

        for open, close in pairs(brackets) do
            if prev_char == open and next_char == close then
                return "<Del><BS>"
            end
        end

        return "<BS>"
    end, { expr = true, noremap = true })
end

-- Prevent inserting duplicate closing brackets
local function set_closing_jump_mappings()
    for _, close in pairs(brackets) do
        vim.keymap.set("i", close, function()
            local line = vim.fn.getline(".")
            local col = vim.fn.col(".")
            local next_char = line:sub(col, col)

            if next_char == close then
                return "<Right>"
            end
            return close
        end, { expr = true, noremap = true })
    end
end

-- Setup function (calls all mapping functions)
function M.setup()
    set_autoclose_mappings()
    set_backspace_mapping()
    set_closing_jump_mappings()
end

return M
