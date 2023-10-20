-- Setup nvim config file finder
local nvim_config_files = function()
  require("telescope.builtin").find_files({
    cwd = "~/.config/nvim",
    prompt_title = "Find neovim config files"
  })
end

-- Function for defining a telescope picker over all the files that I manage using yadm.io.
local yadm_files = function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values

  local opts = {
    theme = "dropdown",
    previewer = false,
    layout_config = {
      height = 20,
      width = 80,
    },
  }
  local files_string = vim.fn.system("yadm list -a") or ""
  local files = vim.split(files_string, "\n")

  pickers.new(opts, {
    prompt_title = "YADM Config Files",
    finder = finders.new_table({
      results = files,
      entry_maker = function(entry)
        -- meow
        return {
          value = "~/" .. entry,
          display = entry,
          ordinal = entry,
        }
      end,
    }),
    previewer = conf.file_previewer(opts),
    sorter = conf.file_sorter(opts),
  }):find()
end

return {
  nvim_config_files = nvim_config_files,
  yadm_files = yadm_files
}
