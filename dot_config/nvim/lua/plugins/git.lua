return {
  -- ╭────────────────────────────────────────────────╮
  -- │ Plugin for calling lazygit from within neovim. │
  -- ╰────────────────────────────────────────────────╯
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "LazyGit", "LazyGitConfig" },
  },

  {
    "TimUntersberger/neogit",
    enabled = false,
    opts = function()
      local nf_fa_folder = ""
      local nf_fa_folder_open = ""

      return {
        signs = {
          section = { nf_fa_folder, nf_fa_folder_open },
          item = { nf_fa_folder, nf_fa_folder_open }
        }
      }
    end
  }
}
