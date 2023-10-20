return {

  -- ╭───────────────────────────╮
  -- │ Hyperfocus-writing in Vim │
  -- ╰───────────────────────────╯
  {
    "junegunn/limelight.vim",
    cmd = "Limelight",
    init = function()
      vim.g.limelight_paragraph_span = 1
    end
  },
  -- ╭──────────────────────────────────╮
  -- │ Distraction-free writing in Vim. │
  -- ╰──────────────────────────────────╯
  {
    "junegunn/goyo.vim",
    cmd = "Goyo",
    init = function()
      vim.g.goyo_width = 102
    end
  },
  -- ╭────────────────────────────────────╮
  -- │ Markdown preview plugin for Neovim │
  -- ╰────────────────────────────────────╯
  {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    ft = { "markdown" },
    event = "VeryLazy",
    config = function()
      local peek = require("peek")
      peek.setup({})

      vim.api.nvim_create_user_command('PeekOpen', peek.open, {})
      vim.api.nvim_create_user_command('PeekClose', peek.close, {})
    end
  }
}
