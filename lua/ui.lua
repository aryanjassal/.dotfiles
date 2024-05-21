local V = {}

V.stbufnr = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

V.is_activewin = function()
  return vim.api.nvim_get_current_win() == vim.g.statusline_winid
end

V.modes = {
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

V.stl_mode = function()
  if not V.is_activewin() then
    return ""
  end

  local modes = V.modes
  local m = vim.api.nvim_get_mode().mode
  return "%#St_" .. modes[m][2] .. "mode#" .. "  " .. modes[m][1] .. " "
end

V.stl_cursor = function()
  return "%#StText# %l:%c "
end

V.stl_lsp = function()
  if rawget(vim, "lsp") then
    for _, client in ipairs(vim.lsp.get_active_clients()) do
      if
        client.attached_buffers[V.stbufnr()] --[[and client.name ~= "null-ls"]]
      then
        return "%#St_Lsp#" .. ((vim.o.columns > 100 and " 󰅩 " .. client.name .. "  ") or " 󰅩 LSP  ")
      end
    end
  end
  return ""
end

V.stl_git_branch = function()
  if not vim.b[V.stbufnr()].gitsigns_head or vim.b[V.stbufnr()].gitsigns_git_status then
    return ""
  end
  local git_status = vim.b[V.stbufnr()].gitsigns_status_dict
  local branch_name = " " .. git_status.head
  return " %#St_gitHead#" .. branch_name .. "%#StText# "
end

V.stl_git_changes = function()
  if not vim.b[V.stbufnr()].gitsigns_head or vim.b[V.stbufnr()].gitsigns_git_status then
    return ""
  end

  local git_status = vim.b[V.stbufnr()].gitsigns_status_dict

  local added = (git_status.added and git_status.added ~= 0) and ("%#St_gitAdded#  " .. git_status.added) or ""
  local changed = (git_status.changed and git_status.changed ~= 0) and ("%#St_gitChanged# 󰻂 " .. git_status.changed)
    or ""
  local removed = (git_status.removed and git_status.removed ~= 0) and ("%#St_gitRemoved#  " .. git_status.removed)
    or ""

  return " " .. added .. changed .. removed
end

return V
