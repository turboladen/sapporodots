return {
  {
    "vim-test/vim-test",
    dependencies = {
      "tpope/vim-dispatch",
      "voldikss/vim-floaterm",
    },
    init = function()
      vim.g.floaterm_wintype = "split"
      vim.g.floaterm_autoclose = 1
      vim.g.floaterm_autoinsert = false
      vim.g.floaterm_height = 0.3

      vim.g["test#strategy"] = {
        nearest = "floaterm",
        last = "floaterm",
        file = "dispatch",
        suite = "dispatch"
      }
      vim.g["test#preserve_screen"] = 1
      vim.g["test#enabled_runners"] = {
        "ruby#rspec",
        "ruby#rails",
        "rust#cargotest"
      }

      vim.g["test#rust#cargotest#test_options"] = {
        nearest = { '--', '--nocapture' },
      }
    end,
  },

  -- ╭───────────────────────────────────────────────────────────────────╮
  -- │ An extensible framework for interacting with tests within NeoVim. │
  -- ╰───────────────────────────────────────────────────────────────────╯
  {
    "nvim-neotest/neotest",
    lazy = true,
    enabled = false,
    dependencies = {
      "antoinemadec/FixCursorHold.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-rspec",
      "rouge8/neotest-rust"
    },
    opts = function()
      return {
        adapters = {
          require('neotest-rspec'),
          require("neotest-rust")
        },
        output = {
          enabled = false
        },
        output_panel = {
          open = "botright split | resize | clear"
        },
      }
    end,
    keys = function()
      local utils = require("plugins.testing.neotest_utils")

      return {
        { "<leader>tn", utils.test_nearest,      desc = "Run the nearest test" },
        { "<leader>td", utils.debug_nearest,     desc = "Debug the nearest test" },
        { "<leader>tf", utils.test_current_file, desc = "Test the current file" },
        {
          "<leader>tt", function() require("neotest").output.open({ enter = true }) end, desc = "Toggle test output pane"
        },
        {
          "<leader>to",
          function() require("neotest").output_panel.open({ enter = true }) end,
          desc = "Toggle test output panel"
        },
        {
          "[n",
          function() require("neotest").jump.prev({ status = "failed" }) end,
          desc = "Jump: previous failed test"
        },
        {
          "[n",
          function() require("neotest").jump.next({ status = "failed" }) end,
          desc = "Jump: next failed test"
        },
      }
    end,
  }
}
