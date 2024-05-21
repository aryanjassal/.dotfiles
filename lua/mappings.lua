require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>tt", ":TroubleToggle<CR>", { desc = "Toggle lsp overview" })
map("n", "<leader>uu", ":BatchUpdate<CR>", { desc = "Batch update" })

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

-- Zen mode
map("n", "<leader>zn", function()
  require("zen-mode").toggle()
end, { desc = "Zen mode" })

-- Todo Comments
map("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "Telescope find all TODOs" })
map("n", "<leader>td", ":TodoTrouble<CR>", { desc = "Trouble find all TODOs" })
