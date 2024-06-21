require "nvchad.options"

-- add yours here!

local o = vim.o
o.guifont = 'JetBrainsMono Nerd Font:h10'
-- o.cursorlineopt ='both' -- to enable cursorline!

-- override neovim's inbulit commenting (v0.10 above)
local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
  return option == "commentstring"
    and require("ts_context_commentstring.internal").calculate_commentstring()
    or get_option(filetype, option)
end
