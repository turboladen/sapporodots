return {
  -- ╭──────────────────────────────────────────────────────────────────────╮
  -- │  This plugin is a replacement for the included filetype.vim that is  │
  -- │  sourced on startup.                                                 │
  -- ╰──────────────────────────────────────────────────────────────────────╯
  {
    "nathom/filetype.nvim",
    lazy = false,
    opts = {
      overrides = {
        extensions = {
          -- Set the filetype of *.pn files to potion
          jbuilder = "ruby"
        },
        complex = {
          ["*.rs.hbs"] = "rust.handlebars", -- Included in the plugin
        },
      },
    },
    config = function(_, opts)
      require("filetype").setup(opts)
    end
  },
  -- ╭────────────────────────────────╮
  -- │ A solid language pack for Vim. │
  -- ╰────────────────────────────────╯
  {
    "sheerun/vim-polyglot",
    priority = 900,
    init = function()
      -- https://github.com/tbastos/vim-lua
      vim.g.lua_syntax_fancynotequal = 1

      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 0
      vim.g.vim_markdown_follow_anchor = 1
      vim.g.vim_markdown_new_list_item_indent = 2
      vim.g.vim_markdown_no_default_key_mappings = 1
      vim.g.vim_markdown_strikethrough = 1
    end
  },

  -- ╭────────────────────────────────────────────────────╮
  -- │ Vim syntax file & snippets for Docker's Dockerfile │
  -- ╰────────────────────────────────────────────────────╯
  { "ekalinin/Dockerfile.vim" },

  -- ╭───────────────────────────────────────────────────────────╮
  -- │ A Vim plugin for more pleasant editing on commit messages │
  -- ╰───────────────────────────────────────────────────────────╯
  {
    "rhysd/committia.vim",
    init = function()
      vim.g.committia_hooks = {}

      vim.g.committia_hooks.edit_open = function(info)
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"

        -- If no commit message, start with insert mode
        if info.vcs == "git" and vim.fn.getline(1) == "" then
          vim.fn.startinsert()
        end
      end
    end
  },

  -- ╭───────────────╮
  -- │ emmet for vim │
  -- ╰───────────────╯
  {
    "mattn/emmet-vim",
    ft = { "html" },
  },

  --  ╭──────────╮
  --  │ Justfile │
  --  ╰──────────╯
  {
    "IndianBoy42/tree-sitter-just",
    opts = {}
  },

  -- ╭───────────────────────────╮
  -- │ Ruby on Rails power tools │
  -- ╰───────────────────────────╯
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby", "rspec" },
  },
  -- ╭───────────────────────────────────────╮
  -- │ It's like rails.vim without the rails │
  -- ╰───────────────────────────────────────╯
  {
    "tpope/vim-rake",
    ft = { "ruby", "eruby", "rspec" },
    dependencies = {
      "tpope/vim-projectionist",
    },
  },

  -- ╭─────╮
  -- │ RBS │
  -- ╰─────╯
  -- use '~/Development/projects/vim-rbs'
  {
    "turboladen/vim-rbs",
    ft = { "ruby", "rbs", "ruby.rbs", "rspec" }
  },

  -- ╭───────────────────────────────────────────────────────────────────────────╮
  -- │ Restores `FocusGained` and `FocusLost` autocommand events work when using │
  -- │ vim inside Tmux.                                                          │
  -- ╰───────────────────────────────────────────────────────────────────────────╯
  { "tmux-plugins/vim-tmux-focus-events" },

  -- ┌╌╌╌╌╌╌╌╌╌╌┐
  -- ╎ wren     ╎
  -- └╌╌╌╌╌╌╌╌╌╌┘
  {
    "kettek/vim-wren-syntax",
    enabled = false,
    ft = "wren",
  },

  -- ╭────────────────────────────────────────────╮
  -- │ Override vim syntax for yaml files.        │
  -- │                                            │
  -- │ Also, this isn't provided in vim-polyglot. │
  -- ╰────────────────────────────────────────────╯
  {
    "stephpy/vim-yaml",
    ft = "yaml",
  },

  --  ╭────────────╮
  --  │ eww's yuck │
  --  ╰────────────╯
  {
    "elkowar/yuck.vim",
    -- ft = "yuck",
  },
}
