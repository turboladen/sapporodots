function CustomOpenFloaterm()
  if vim.g.floaterm_already_opened then
    vim.cmd("FloatermToggle myfloat")
  else
    vim.g.floaterm_already_opened = true
    vim.cmd("FloatermNew --wintype=split --height=20 --position=botright --autoclose=2 --name=myfloat zsh")
  end
end

return {
  --  ╭────────────────────────────────────────────────────────╮
  --  │ A fancy, configurable, notification manager for NeoVim │
  --  ╰────────────────────────────────────────────────────────╯
  {
    "rcarriga/nvim-notify",
    priority = 1000,
    dependencies = {
      "yamatsum/nvim-nonicons",
      "nvim-telescope/telescope.nvim",
    },
    init = function()
      vim.opt.termguicolors = true
    end,
    opts = {
      timeout = 3000,
      icons = require("nvim-nonicons.extentions.nvim-notify").icons
    },
    config = function(_, opts)
      vim.notify = require("notify")
      require("notify").setup(opts)

      local telescope = require("telescope")
      telescope.load_extension("notify")
    end
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ Neovim plugin to improve the default vim.ui interfaces │
  -- ╰────────────────────────────────────────────────────────╯
  {
    'stevearc/dressing.nvim',
    event = "VeryLazy",
  },

  -- ╭─────────────────────────────────────╮
  -- │ A neovim port of Assorted Biscuits. │
  -- ╰─────────────────────────────────────╯
  {
    "code-biscuits/nvim-biscuits",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    enabled = false,
    event = "VeryLazy",
    opts = function()
      -- local icon = ""
      local icon = "✨"

      return {
        toggle_keybind = "<leader>cb",
        show_on_start = true,
        cursor_line_only = true,
        default_config = {
          max_distance = 25,
          prefix_string = " " .. icon .. " ",
        }
      }
    end
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Prismatic line decorations for the adventurous vim user │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "mvllow/modes.nvim",
    tag = "v0.2.0",
    event = "VeryLazy",
    init = function()
      vim.opt.cursorline = true
    end,
    config = function()
      require("modes").setup()
    end
  },

  -- ╭──────────────────────────────────╮
  -- │ 🌟 Terminal manager for (neo)vim │
  -- ╰──────────────────────────────────╯
  {
    "voldikss/vim-floaterm",
    keys = {
      { "<leader>ww", CustomOpenFloaterm, desc = "Open a floating term" },
    },
    init = function()
      vim.g.floaterm_already_opened = false
    end,
  },

  --  ╭────────────────────────────────────────────────────╮
  --  │ A snazzy 💅 buffer line (with tabpage integration) │
  --  ╰────────────────────────────────────────────────────╯
  -- https://github.com/LazyVim/LazyVim/blob/2e7ad2b8257b7d25df0264a5b193da7af35f5a53/lua/lazyvim/plugins/ui.lua#L53
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = require("turboladen").signs
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
              .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
      }
    }
  },

  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │ A blazing fast and easy to configure neovim statusline plugin written        │
  -- │  in pure lua.                                                                │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'stevearc/aerial.nvim',
    },
    opts = function()
      -- ╭───────────────────────────────────────────────────────────────────────────────────────────╮
      -- │ Bubbles config for lualine                                                                │
      -- │ Author: lokesh-krishna                                                                    │
      -- │ MIT license, see LICENSE for more details.                                                │
      -- │ https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/bubbles.lua#enroll-beta │
      -- ╰───────────────────────────────────────────────────────────────────────────────────────────╯
      -- bubbly.nvim colors
      local colors = {
        blue = "#6cb6eb",
        cyan = "#5dbbc1",
        black = "#3e4249",
        black2 = "#111111",
        white = "#c5cdd9",
        red = "#ec7279",
        violet = "#d38aea",
        lightgrey = "#57595e",
        darkgrey = "#404247",
        darkorange = "#844212"
      }

      local bubbles_theme = {
        normal = {
          a = { fg = colors.black, bg = colors.violet },
          b = { fg = colors.white, bg = colors.lightgrey },
          c = { fg = colors.black, bg = colors.darkgrey },
        },
        insert = { a = { fg = colors.black, bg = colors.blue } },
        visual = { a = { fg = colors.black, bg = colors.cyan } },
        replace = { a = { fg = colors.black, bg = colors.red } },
        inactive = {
          a = { fg = colors.white, bg = colors.darkgrey },
          b = { fg = colors.white, bg = colors.darkgrey },
          c = { fg = colors.black, bg = colors.darkgrey },
        },
      }

      return {
        options = {
          theme = bubbles_theme,
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
          },
          lualine_b = {
            { 'branch', color = { bg = colors.darkorange } },
            { 'diff', separator = { right = "" }, color = { bg = "#000000" } },
            { 'filename', path = 1, separator = { right = "" } },
          },
          lualine_c = { 'tabs' },
          lualine_x = {
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = { fg = "#ff9e64" },
            },
          },
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = {
            { 'filename', path = 1 },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = { "aerial", "quickfix", "trouble" },
      }
    end
  },



  -- ╭──────────────────────────────────────────╮
  -- │ Show vertical line for indentation level │
  -- ╰──────────────────────────────────────────╯
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- char = "┊",
      -- char_highlight = "LineNr",
      -- buftype_exclude = { "terminal", "nofile" },
      -- filetype_exclude = {
      --   "Trouble",
      --   "help",
      --   "lazy",
      --   "lua",
      --   "mason",
      --   "notify",
      --   "ruby",
      --   "rust",
      -- },
      -- space_char_blankline = " ",
      -- show_current_context = true,
      -- show_current_context_start = true,
    },
    config = function(_, opts)
      require("ibl").setup(opts)
    end,
    init = function()
      vim.opt.list = true
    end
  },

  --  ╭─────────────────────────────────────────────╮
  --  │ active indent guide and indent text objects │
  --  ╰─────────────────────────────────────────────╯
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "Trouble",
          "help",
          "lazy",
          "lazyterm",
          "mason",
          "notify",
          "ruby",
          "rust"
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Icon set using nonicons for neovim plugins and settings │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "yamatsum/nvim-nonicons",
    lazy = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function(_, opts)
      require('nvim-nonicons').setup(opts)
    end
  },
  -- ╭─────────────────────────────╮
  -- │ Extensible Neovim Scrollbar │
  -- ╰─────────────────────────────╯
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    opts = {},
  },

  {
    'Bekaboo/dropbar.nvim',
    enabled = false,
    opts = {}
  },

  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",        -- Optional
      "nvim-telescope/telescope.nvim" -- Optional
    },
    opts = {
      -- lsp = {
      --   auto_attach = true
      -- }
    },
    -- keys = {
    --   { "<leader>cn", function() require("nvim-navbuddy").open() end, desc = "Navbuddy" }
    -- }
  }
}
