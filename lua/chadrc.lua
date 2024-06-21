---@type ChadrcConfig
local M = {}

local utils = require "nvchad.stl.utils"

M.ui = {
  theme = "tokyodark",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },

  hl_add = {
    St_gitHead = { fg = "red" },
    CodewindowBorder = { fg = "black" },
  },

  tabufline = {
    order = { "treeOffset", "buffers", "tabs" },
  },

  statusline = {
    theme = "vscode_colored",
    order = { "mode", "file", "git", "diagnostics", "%=", "lsp_msg", "%=", "cursor", "lsp", "cwd" },
    modules = {
      mode = function()
        if not utils.is_activewin() then
          return ""
        end

        local m = vim.api.nvim_get_mode().mode
        return "%#St_" .. utils.modes[m][2] .. "mode#" .. "  " .. utils.modes[m][1] .. " "
      end,

      cursor = function()
        return "%#StText# %l:%c "
      end,

      lsp = function()
        if rawget(vim, "lsp") then
          for _, client in ipairs(vim.lsp.get_clients()) do
            if client.attached_buffers[utils.stbufnr()] then
              return "%#St_Lsp#" .. ((vim.o.columns > 100 and " 󰅩 LSP " .. client.name .. " ") or " 󰅩 LSP ")
            end
          end
        end

        return ""
      end,

      git = function()
        if not vim.b[utils.stbufnr()].gitsigns_head or vim.b[utils.stbufnr()].gitsigns_git_status then
          return ""
        end

        local git_status = vim.b[utils.stbufnr()].gitsigns_status_dict
        local branch_name = " " .. git_status.head
        return "%#St_gitHead# " .. branch_name
      end,
    },
  },
}

return M
