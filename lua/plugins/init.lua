return {
  {
    "stevearc/conform.nvim",
    -- event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup {
        filetypes = { "css" },
      }
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
    "numToStr/Comment.nvim",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },

  {
    "VonHeikemen/searchbox.nvim",
    dependencies = "MunifTanjim/nui.nvim",
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
    end,
  },

  {
    "gorbit99/codewindow.nvim",
    config = true,

    init = function()
      require("codewindow").apply_default_keybinds()
    end,
  },

  {
    "folke/zen-mode.nvim",
  },

  {
    "folke/twilight.nvim",
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
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "folke/trouble.nvim",
    },

    opts = {
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "warning" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },

    config = true,
    lazy = false,
  },

  -- -- I need to enable Discord RPC first T_T
  -- {
  --   "andweeb/presence.nvim",
  --   config = function()
  --     require("presence").setup {
  --       -- General options
  --       auto_update = true,
  --       neovim_image_text = "The One True Text Editor",
  --       main_image = "neovim",
  --       debounce_timeout = 10,
  --       blacklist = {"polykey", "infered", "matrix"},
  --       show_time = true,
  --
  --       -- Rich Presence text options
  --       editing_text = "Editing %s",
  --       file_explorer_text = "Browsing %s",
  --       reading_text = "Reading %s",
  --       workspace_text = "Working on %s",
  --       line_number_text = "Line %s out of %s",
  --     }
  --   end,
  -- },
}
