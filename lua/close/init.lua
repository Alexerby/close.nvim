local M = {}

function M.setup()
    -- Define bracket pairs to auto-close
    local brackets = {
        ["("] = ")",
        ["["] = "]",
        ["{"] = "}",
        ['"'] = '"',
        ["'"] = "'",
        ["<"] = ">"
    }

    --------------------------------------------------------------
    -- Auto-close brackets on opening keypress in insert mode
    --------------------------------------------------------------
    for open, close in pairs(brackets) do
        -- When 'open' key is pressed, insert open + close brackets
        -- and move cursor one position left (inside the pair)
        vim.keymap.set("i", open, function()
            return open .. close .. "<Left>"
        end, { expr = true, noremap = true })
    end

    --------------------------------------------------------------
    -- Backspace: delete both brackets if cursor is between them
    -------------------------------------------------------------- 
    vim.keymap.set("i", "<BS>", function() -- trigger function when <BS> in "i" mode
        local col = vim.fn.col(".") -- current cursor column (1-indexed)

        -- If at start of line, just do normal backspace
        if col == 1 then
            return "<BS>"
        end

        local line = vim.fn.getline(".")           -- current line as string
        local prev_char = line:sub(col - 1, col - 1) -- char before cursor
        local next_char = line:sub(col, col)          -- char at cursor

        -- check if the chars around the cursor form an open-close pair
        for open, close in pairs(brackets) do
            if prev_char == open and next_char == close then
                -- Delete both brackets: delete closing then opening
                return "<Del><BS>"
            end
        end
        -- default backspace behaviour
        return "<BS>"
    end, { expr = true, noremap = true })

    --------------------------------------------------------------
    -- Jump out of bracket instead of creating new one
    -------------------------------------------------------------- 
    for _, close in pairs(brackets) do
        -- When close event
        vim.keymap.set("i", close, function()
            -- get next char (exactly one character at cursor)
            local line = vim.fn.getline(".")
            local col = vim.fn.col(".")
            local next_char = line:sub(col, col)

            if close == next_char then
                return "<Right>"
            end
            -- fallback: insert the character normally
            return close
        -- expr = true -> return value used as keys to feed into nvim
        end, { expr = true, noremap = true })
    end
end

return M

