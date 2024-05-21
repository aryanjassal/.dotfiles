vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

-- define local autocmds
local autocmd = vim.api.nvim_create_autocmd

-- auto-resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- match .vs .fs .gs files for glsl shader syntax highlighting
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.fs", "*.gs", "*.vs" },
  callback = function()
    vim.cmd "set ft=glsl"
  end,
})

autocmd("FileType", {
  desc = "Close NvimTree before quitting nvim",
  pattern = { "NvimTree" },
  callback = function(args)
    autocmd("VimLeavePre", {
      callback = function()
        vim.api.nvim_buf_delete(args.buf, { force = true })
        return true
      end,
    })
  end,
})

autocmd("FileType", {
  desc = "Auto-close windows by pressing <ESC>",
  pattern = {
    "empty",
    "help",
    "startuptime",
    "qf",
    "lspinfo",
    "man",
    "checkhealth",
    "Trouble",
    "NeogitStatus",
  },
  command = [[
    nnoremap <buffer><silent> <ESC> :close<CR>
    set nobuflisted
  ]],
})

-- define user-level commands
local create_cmd = vim.api.nvim_create_user_command

create_cmd("BatchUpdate", function()
	require("lazy").load({ plugins = { "mason.nvim", "nvim-treesitter" } })
	vim.cmd("MasonUpdate")
	vim.cmd("TSUpdate")
end, {})

vim.schedule(function()
  require "mappings"
end)
