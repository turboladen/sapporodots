local function add_server()
  local configs = require('lspconfig.configs')
  local target_dir = "/Users/steve.loveless/Development/projects/ruby_analyzer/target/debug/"
  local bin_name = "ruby_analyzer-lsp_server"

  if not configs.ruby_analyzer then
    configs.ruby_analyzer = {
      default_config = {
        name = "ruby_analyzer",
        cmd = { target_dir .. bin_name },
        filetypes = { "ruby" },
        root_dir = function(fname)
          return require("lspconfig").util.find_git_ancestor(fname)
        end,
        settings = {}
      },
    }
  end
  vim.lsp.set_log_level 'trace'
end

return {
  add_server = add_server
}
