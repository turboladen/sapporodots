return {
  --  ╭──────────────────────────────────────────────────────────╮
  --  │ 💾 Simple session management for Neovim with git         │
  --  │  branching, autoloading and Telescope support.           │
  --  ╰──────────────────────────────────────────────────────────╯
  {
    "olimorris/persisted.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      autoload = true,
      on_autoload_no_session = function()
        vim.notify("No existing session to load.")
      end,
      -- multiple sessions files for a given project, by using git branches
      use_git_branch = true,
      save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
    },
    config = function(_, opts)
      require("persisted").setup(opts)
      local group = vim.api.nvim_create_augroup("PersistedHooks", {})

      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "PersistedSavePre",
        group = group,
        callback = function()
          pcall(vim.cmd, ":TroubleClose<CR>")
        end,
      })

      require("telescope").load_extension("persisted")
    end,
    init = function()
      vim.o.sessionoptions = "buffers,curdir,folds,winpos,winsize"
    end
  },

  {
    "nvim-lua/plenary.nvim",
    lazy = true
  },

  -- ╭──────────────────────────────────────────────────╮
  -- │  Enable repeating supported plugin maps with '.' │
  -- ╰──────────────────────────────────────────────────╯
  {
    "tpope/vim-repeat",
    event = "VeryLazy"
  },

  -- ╭───────────────────────────────────────────────────────────────────────────╮
  -- │ Open the current word with custom openers, GitHub shorthands for example. │
  -- ╰───────────────────────────────────────────────────────────────────────────╯
  {
    {
      'ofirgall/open.nvim',
      event = "VeryLazy",
      dependencies = {
        'nvim-lua/plenary.nvim',
        "stevearc/dressing.nvim"
      },
      config = function(_, opts)
        require("open").setup(opts)
        vim.keymap.set('n', 'gx', require("open").open_cword, { desc = "Try to open thing under cursor" })
      end
    },
    -- Opener of open.nvim that opens shorthands of Jira tickets, E.g: JRASERVER-63928.
    {
      'ofirgall/open-jira.nvim',
      dependencies = { 'ofirgall/open.nvim' },
      event = "VeryLazy",
      opts = {
        url = "https://telusagriculture.atlassian.net/browse/"
      },
    }
  }
}
