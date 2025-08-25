local U = {}

-- Table of bracket pairs
U.brackets = {
    ["("] = ")",
    ["["] = "]",
    ["{"] = "}",
    ['"'] = '"',
    ["'"] = "'",
}

-- Check if cursor is inside a bracket pair
function U.inside_brackets()
    local col = vim.fn.col(".")

    -- Check that cursor not start of line
    if col == 1 then
        return false
    end

    local line = vim.fn.getline(".")
    local prev_char = line:sub(col - 1, col - 1)
    local next_char = line:sub(col, col)

    for open, close in pairs(U.brackets) do
        if prev_char == open and next_char == close then
            return true
        end
    end

    return false
end

return U
