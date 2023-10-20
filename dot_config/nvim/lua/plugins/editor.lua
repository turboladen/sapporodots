return {
  -- ╭──────────────────────────────────────────────────────────╮
  -- │    A file manager for Neovim which lets you edit your    │
  -- │              filesystem like you edit text               │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "elihunter173/dirbuf.nvim",
    event = "VeryLazy"
  },

  -- ╭─────────────────────────────────────────────────────╮
  -- │ Find, Filter, Preview, Pick. All lua, all the time. │
  -- ╰─────────────────────────────────────────────────────╯
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    -- lazy = false,
    dependencies = {
      "yamatsum/nvim-nonicons",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      local icons = require("nvim-nonicons")

      return {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = require("telescope.actions").close,
            },
          },
          prompt_prefix = "  " .. icons.get("telescope") .. "  ",
          selection_caret = " ❯ ",
          entry_prefix = "   ",
        },
        pickers = {
          buffers = {
            theme = "cursor",
            previewer = false,
          },
          find_files = {
            theme = "dropdown",
            previewer = false,
          },
          lsp_code_actions = {
            theme = "cursor",
            layout_config = { height = 15 },
          },
          oldfiles = {
            theme = "dropdown",
          },
        },
      }
    end,
  },

  -- ╭───────────────────────────────────────────────────────────────────────╮
  -- │ Alternate between common files using pre-defined regexp. Just map the │
  -- │ patterns and starting navigating between files that are related.      │
  -- ╰───────────────────────────────────────────────────────────────────────╯
  {
    "otavioschwanck/telescope-alternate",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      mappings = {
        { "app/(.*)/(.*).js", {
          { "app/[1]/adapter.js",                                       "Adapter" },
          { "app/[1]/controller.js",                                    "Controller" },
          { "app/[1]/model.js",                                         "Model" },
          { "app/[1]/route.js",                                         "Route" },
          { "app/[1]/service.js",                                       "Service" },
          { "app/[1]/template.hbs",                                     "Template" },
          { "app/[1]/view.js",                                          "View" },
          { "../backend/app/assets/javascripts/pods/[1]/adapter.js",    "Old Adapter" },
          { "../backend/app/assets/javascripts/pods/[1]/controller.js", "Old Controller" },
          { "../backend/app/assets/javascripts/pods/[1]/model.js",      "Old Model" },
          { "../backend/app/assets/javascripts/pods/[1]/route.js",      "Old Route" },
          { "../backend/app/assets/javascripts/pods/[1]/view.js",       "Old View" },
          { "tests/[1]/controller-test.js",                             "Controller Tests" },
          { "tests/[1]/route-test.js",                                  "Route Tests" },
          { "tests/[1]/model-test.js",                                  "Model Tests" },
          { "tests/[1]/service-test.js",                                "Service Tests" },
          { "tests/[1]/view-test.js",                                   "View Tests" },
        } }
      },
      presets = { "rails", "rspec" }
    },
    config = function(_, opts)
      local telescope = require("telescope")
      require("telescope-alternate").setup(opts)

      telescope.load_extension("telescope-alternate")
    end
  },

  --  ╭────────────────────────────────────╮
  --  │ 💥 Create key bindings that stick. │
  --  ╰────────────────────────────────────╯
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- init = function()
    --   vim.o.timeout = true
    --   vim.o.timeoutlen = 300
    -- end,
    opts = {
      plugins = { spelling = true },
      defaults = {
        -- ["g"] = { name = "+goto" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>t"] = { name = "+test" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      }
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end
  },

  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "✚" },
        change = { text = "▎" },
        delete = { text = "✖" },
        changedelete = { text = "⇄" },
      },
      current_line_blame = true,
      -- yadm = { enable = true },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function get_next_hunk()
          if vim.wo.diff then return ']c' end
          -- vim.schedule(function() require("gitsigns").next_hunk() end)
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end

        local function get_prev_hunk()
          if vim.wo.diff then return '[c' end
          -- vim.schedule(function() require("gitsigns").prev_hunk() end)
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end

        local function toggle_blame()
          -- require("gitsigns").toggle_current_line_blame()
          gs.toggle_current_line_blame({ full = true })
        end

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Actions
        map("n", "]c", get_next_hunk, "Next hunk")
        map("n", "[c", get_prev_hunk, "Previous hunk")
        map("n", "<leader>ghb", toggle_blame, "Toggle git blame line")
      end,
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end
  },


  -- ╭──────────────────────────────────────────────────────────────────────╮
  -- │ 🚦 A pretty diagnostics, references, telescope results, quickfix and │
  -- │ location list to help you solve all the trouble your code is causing.│
  -- ╰──────────────────────────────────────────────────────────────────────╯
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleRefresh", "TroubleToggle" },
    opts = {
      auto_close = true,
      use_diagnostic_signs = true
    },
  },

  -- ╭─────────────────────────────────────────╮
  -- │ Neovim plugin for a code outline window │
  -- ╰─────────────────────────────────────────╯
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    lazy = true,
    opts = {
      filter_kind = false,
      on_attach = function(bufnr)
        require('which-key').register({
          ["<leader>a"] = {
            name = "aerial",
            a = { require("aerial").toggle, "aerieal: toggle", buffer = bufnr },
          }
        })
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", require("aerial").prev, opts)
        vim.keymap.set("n", "}", require("aerial").next, opts)

        -- Jump up the tree with '[[' or ']]'
        vim.keymap.set("n", "[[", require('aerial').prev_up, opts)
        vim.keymap.set("n", "]]", require('aerial').next_up, opts)
      end
    },
    config = function(_, opts)
      local telescope = require("telescope")
      require("aerial").setup(opts)
      telescope.load_extension('aerial')
    end
  },

  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │ Highlight and search for todo comments like TODO, HACK, BUG in your      │
  -- │ code base.                                                               │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- ╭──────────────────────────╮
  -- │ Hlsearch Lens for Neovim │
  -- ╰──────────────────────────╯
  {
    "kevinhwang91/nvim-hlslens",
    opts = {}
  },
  -- ╭─────────────────────────────────────────────────────────────╮
  -- │ Vim sugar for the UNIX shell commands that need it the most │
  -- ╰─────────────────────────────────────────────────────────────╯
  {
    "tpope/vim-eunuch",
    cmd = {
      "Chmod",
      "Delete",
      "Mkdir",
      "Move",
      "Remove",
      "Rename",
      "Unlink",
    },
  },

  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │ Asynchronous build and test dispatcher. Used for running specs in a      │
  -- │ separate tmux pane.                                                      │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  {
    "tpope/vim-dispatch",
    cmd = {
      "AbortDispatch",
      "Copen",
      "Dispatch",
      "FocusDispatch",
      "Make",
      "Spawn",
      "Start",
    },
    init = function()
      vim.g.dispatch_no_maps = 1
    end
  },

  -- ╭───────────────────────────────────────────────────────────╮
  -- │ Use RipGrep in Vim and display results in a quickfix list │
  -- ╰───────────────────────────────────────────────────────────╯
  {
    "jremmen/vim-ripgrep",
    cmd = "Rg",
    init = function()
      vim.g.rg_command = "rg --vimgrep --ignore-vcs"
      -- vim.g.rg_highlight = 1
    end
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ Delete all the buffers except the current/named buffer │
  -- ╰────────────────────────────────────────────────────────╯
  { "vim-scripts/BufOnly.vim", cmd = "BufOnly" },

  -- ╭────────────────────────────────────────╮
  -- │ Enhanced terminal integration for Vim. │
  -- ╰────────────────────────────────────────╯
  {
    "wincent/terminus",
    event = "VeryLazy"
  },

  -- ╭──────────────────────────────────────────╮
  -- │ Change code right in the quickfix window │
  -- ╰──────────────────────────────────────────╯
  {
    "stefandtw/quickfix-reflector.vim",
    event = "VeryLazy"
  },
}
