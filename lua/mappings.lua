require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>tt", ":Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Toggle diagnostics pane" })
map("n", "<leader>ts", ":Trouble symbols toggle pinned=true results.win.relative=win<CR>", { desc = "Toggle symbols pane" })

-- Use seachbox to find and/or replace all matching words
map("n", "<leader>fi", ":SearchBoxMatchAll<CR>", { desc = "Find all matching words" })
map("n", "<leader>fr", ":SearchBoxReplace<CR>", { desc = "Find and replace all matching words" })
map("x", "<leader>fi", ":SearchBoxMatchAll visual_mode=true<CR>", { desc = "Find all matching words" })
map("x", "<leader>fr", ":SearchBoxReplace visual_mode=true<CR>", { desc = "Find and replace all matching words" })

map("n", "<leader>tn", function()
  require("telescope").extensions.notify.notify()
end, { desc = "Telescope view notification history" })

map("n", "<leader>tr", function()
  require("base46").toggle_transparency()
end, { desc = "Theme toggle transparency" })

map("n", "<leader>qa", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "Close all tabs" })

map("n", "<leader>gg", function()
  require("neogit").open { kind = "floating" }
end, { desc = "Open neogit" })

-- Don't exit out of visual mode even after changing indent
map("x", "<", "<gv", { noremap = true, silent = true })
map("x", ">", ">gv", { noremap = true, silent = true })
