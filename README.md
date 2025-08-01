# close.nvim
A minimal Neovim plugin in Lua that automatically closes brackets and quotes, and enhances cursor movement and deletion inside bracket pairs. 

## Features
- **Auto-close brackets and quotes**: Automatically inserts the matching closing bracket/quote when typing an opening one in insert mode.
- **Smart backspace**: When pressing backspace between an open and close bracket pair, deletes both simultaneously.
- **Jump out of closing brackets**: Pressing the closing bracket key when the cursor is just before a closing bracket will move the cursor past it instead of inserting a duplicate.

## Installation

[Lazyvim](https://github.com/LazyVim/LazyVim)
```lua
return {
    "Alexerby/close.nvim",
    config = function()
        require("close").setup()
    end
}
```

[Packer](https://github.com/wbthomason/packer.nvim)
```Lua
use 'Alexerby/close.nvim'
```
