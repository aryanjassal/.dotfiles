---@type ChadrcConfig
local M = {}

-- helper function
local stbufnr = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

local is_activewin = function()
  return vim.api.nvim_get_current_win() == vim.g.statusline_winid
end

local modes = {
  ["n"] = { "NORMAL", "Normal" },
  ["no"] = { "NORMAL (no)", "Normal" },
  ["nov"] = { "NORMAL (nov)", "Normal" },
  ["noV"] = { "NORMAL (noV)", "Normal" },
  ["noCTRL-V"] = { "NORMAL", "Normal" },
  ["niI"] = { "NORMAL i", "Normal" },
  ["niR"] = { "NORMAL r", "Normal" },
  ["niV"] = { "NORMAL v", "Normal" },
  ["nt"] = { "NTERMINAL", "NTerminal" },
  ["ntT"] = { "NTERMINAL (ntT)", "NTerminal" },

  ["v"] = { "VISUAL", "Visual" },
  ["vs"] = { "V-CHAR (Ctrl O)", "Visual" },
  ["V"] = { "V-LINE", "Visual" },
  ["Vs"] = { "V-LINE", "Visual" },
  [""] = { "V-BLOCK", "Visual" },

  ["i"] = { "INSERT", "Insert" },
  ["ic"] = { "INSERT (completion)", "Insert" },
  ["ix"] = { "INSERT completion", "Insert" },

  ["t"] = { "TERMINAL", "Terminal" },

  ["R"] = { "REPLACE", "Replace" },
  ["Rc"] = { "REPLACE (Rc)", "Replace" },
  ["Rx"] = { "REPLACEa (Rx)", "Replace" },
  ["Rv"] = { "V-REPLACE", "Replace" },
  ["Rvc"] = { "V-REPLACE (Rvc)", "Replace" },
  ["Rvx"] = { "V-REPLACE (Rvx)", "Replace" },

  ["s"] = { "SELECT", "Select" },
  ["S"] = { "S-LINE", "Select" },
  [""] = { "S-BLOCK", "Select" },
  ["c"] = { "COMMAND", "Command" },
  ["cv"] = { "COMMAND", "Command" },
  ["ce"] = { "COMMAND", "Command" },
  ["r"] = { "PROMPT", "Confirm" },
  ["rm"] = { "MORE", "Confirm" },
  ["r?"] = { "CONFIRM", "Confirm" },
  ["x"] = { "CONFIRM", "Confirm" },
  ["!"] = { "SHELL", "Terminal" },
}

M.ui = {
  theme = "tokyodark",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },

  hl_add = {
    St_gitAdded = { fg = "green" },
    St_gitChanged = { fg = "yellow" },
    St_gitRemoved = { fg = "red" },
    St_gitHead = { fg = "nord_blue" },
    CodewindowBorder = { fg = "black" },
  },

  tabufline = {
    order = { "treeOffset", "buffers", "tabs" },
  },

  statusline = {
    theme = "vscode_colored",
    order = { "mode", "file", "git_branch", "diagnostics", "%=", "lsp_msg", "%=", "cursor", "lsp", "cwd" },
    modules = {
      mode = function()
        if not is_activewin() then
          return ""
        end

        local m = vim.api.nvim_get_mode().mode
        return "%#St_" .. modes[m][2] .. "mode#" .. "  " .. modes[m][1] .. " "
      end,

      cursor = function()
        return "%#StText# %l:%c "
      end,

      lsp = function()
        if rawget(vim, "lsp") then
          for _, client in ipairs(vim.lsp.get_active_clients()) do
            if client.attached_buffers[stbufnr()] and client.name ~= "null-ls" then
              return "%#St_Lsp#" .. ((vim.o.columns > 100 and " 󰅩 " .. client.name .. "  ") or " 󰅩 LSP  ")
            end
          end
        end
        return ""
      end,

      git_branch = function()
        if not vim.b[stbufnr()].gitsigns_head or vim.b[stbufnr()].gitsigns_git_status then
          return ""
        end
        local git_status = vim.b[stbufnr()].gitsigns_status_dict
        local branch_name = " " .. git_status.head
        return " %#St_gitHead#" .. branch_name .. "%#StText# "
      end,

      git_changes = function()
        if not vim.b[stbufnr()].gitsigns_head or vim.b[stbufnr()].gitsigns_git_status then
          return ""
        end

        local git_status = vim.b[stbufnr()].gitsigns_status_dict

        local added = (git_status.added and git_status.added ~= 0) and ("%#St_gitAdded#  " .. git_status.added) or ""
        local changed = (git_status.changed and git_status.changed ~= 0)
            and ("%#St_gitChanged# 󰻂 " .. git_status.changed)
          or ""
        local removed = (git_status.removed and git_status.removed ~= 0)
            and ("%#St_gitRemoved#  " .. git_status.removed)
          or ""

        return " " .. added .. changed .. removed
      end,

      lsp_msg = function()
        if not rawget(vim, "lsp") or vim.lsp.status or not is_activewin() then
          return ""
        end

        local Lsp = vim.lsp.util.get_progress_messages()[1]

        if vim.o.columns < 120 or not Lsp then
          return ""
        end

        if Lsp.done then
          vim.defer_fn(function()
            vim.cmd.redrawstatus()
          end, 1000)
        end

        local msg = Lsp.message or ""
        local percentage = Lsp.percentage or 0
        local title = Lsp.title or ""
        local spinners = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" }
        local ms = vim.loop.hrtime() / 1000000
        local frame = math.floor(ms / 120) % #spinners
        local content = string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)

        return "%#St_gitAdded#" .. (content or "")
      end,
    },
  },
}

return M
