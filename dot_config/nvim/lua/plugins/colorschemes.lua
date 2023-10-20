return {
  -- ╭────────────────────────────────────────────────────────────────────────╮
  -- │ 🦊A highly customizable theme for vim and neovim with support for lsp, │
  -- │ treesitter and a variety of plugins.                                   │
  -- ╰────────────────────────────────────────────────────────────────────────╯
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 999,
    opts = {
      options = {
        dim_inactive = true,
        inverse = {
          match_paren = true,
          visual = true,
          search = true,
        },
      },
    },
    config = function(_, opts)
      require("nightfox").setup(opts)
    end
  },

  -- ╭────────────────────────────────────────────────╮
  -- │ 🌲 Comfortable & Pleasant Color Scheme for Vim │
  -- │                                                │
  -- │ NOTE: To enable this, edit the setup file.     │
  -- ╰────────────────────────────────────────────────╯
  {
    "sainnhe/everforest",
    lazy = true,
    init = function()
      vim.g.everforest_background = "hard"

      -- Without this, the background is too light.
      vim.g.everforest_transparent_background = 1
      -- vim.g.everforest_ui_contrast = "low"

      vim.g.everforest_diagnostic_text_highlight = 1
      vim.g.everforest_diagnostic_line_highlight = 1
      vim.g.everforest_diagnostic_virtual_text = "colored"

      vim.g.everforest_enable_italic = 1
    end
  },

  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │ NeoVim dark colorscheme inspired by the colors of the famous             │
  -- │ painting by Katsushika Hokusai.                                          │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },

  -- ╭──────────────────────────────────────────────────────╮
  -- │ A very dark colorscheme for Vim. JOIN THE DARK SIDE! │
  -- ╰──────────────────────────────────────────────────────╯
  {
    "aonemd/kuroi.vim",
    lazy = true
  },

  -- ╭─────────────────────────────────────────────────────────────────────────╮
  -- │ 🔱 Material colorscheme for NeoVim written in Lua with built-in support │
  -- │ for native LSP, TreeSitter and many more plugins .                      │
  -- │                                                                         │
  -- │ NOTE: To enable this, edit the setup file.                              │
  -- ╰─────────────────────────────────────────────────────────────────────────╯
  {
    "marko-cerovac/material.nvim",
    lazy = true,
    priority = 999,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      contrast = {
        floating_windows = true,
        cursor_line = true,
        non_current_windows = true,
      },
      plugins = {
        "dap",
        "gitsigns",
        "indent-blankline",
        "nvim-cmp",
        "nvim-web-devicons",
        "telescope",
        "trouble"
      }
    },
    init = function()
      vim.g.material_style = "palenight"
    end,
    config = function(_, opts)
      require("material").setup(opts)
      -- vim.keymap.set("n", "<leader>C", require("material.functions").find_style(),
      --   { desc = "Pick 'material-nvim' colorscheme style" })
    end,
    keys = {
      {
        "<leader>mm",
        function()
          require("material.functions").find_style()
        end,
        desc = "Pick material-nvim colorscheme style"
      }
    }
  },

  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │ One dark and light colorscheme for neovim >= 0.5.0 written in lua based  │
  -- │ on Atom's One Dark and Light theme. Additionally, it comes with 5 color  │
  -- │ variant styles.                                                          │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  {
    "navarasu/onedark.nvim",
    lazy = true,
    opts = {
      style = "darker"
    }
  }
}
