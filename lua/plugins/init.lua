return {
  {
    "stevearc/conform.nvim",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require "notify"
      notify.setup {
        stages = "slide",
        timeout = 2500,
        max_height = 6,
        max_width = 60,
        fps = 60,
      }
      vim.notify = notify
    end,
    lazy = false,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
    end,
    lazy = false,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "warning" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "󰦒 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
    lazy = false,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local conf = require "nvchad.configs.telescope"

      conf.defaults.mappings.i = {
        ["<Tab>"] = require("telescope.actions").move_selection_next,
        ["<S-Tab>"] = require("telescope.actions").move_selection_previous,
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      }

      return conf
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      local conf = require "nvchad.configs.gitsigns"
      conf.signs.delete = { text = "│" }
      conf.signs.changedelete = { text = "~" }
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local style = "default"
      local arrangement = {
        atom = { "kind", "abbr", "menu" },
        default = { "abbr", "kind", "menu" },
      }
      local conf = require "nvchad.configs.cmp"
      conf.performance = { max_view_entries = 6 }
      conf.formatting = {
        fields = arrangement[style],
        format = function(_, item)
          local icons = require "nvchad.icons.lspkind"
          local icon = icons[item.kind] or ""

          if style == "atom" then
            icon = " " .. icon .. " "
            item.menu = ("   (" .. item.kind .. ")") or ""
            item.kind = icon
          else
            icon = (" " .. icon .. " ") or icon
            item.menu = ""
            item.kind = string.format("%s %s", icon, item.kind or "")
          end

          return item
        end,
      }
    end,
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("ts_context_commentstring").setup {
        enable_autocmd = false,
      }
    end,
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        pre_hook = function()
          return vim.bo.commentstring
        end,
      }
    end,
  },
}
