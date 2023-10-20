-- typos-cli, when used with `--format json` outputs errors that look like this:
--
--   {"type":"binary_file","path":"./lua/init_rs.so"}
--   {"type":"typo","path":"./lua/plugins/23_package-info-nvim.lua","line_num":15,"byte_offset":37,"typo":"nd","corrections":["and"]}
--   {"type":"typo","path":"./lua/plugins/01_nvim-notify.lua","line_num":12,"byte_offset":35,"typo":"extentions","corrections":["extensions"]}
--   {"type":"typo","path":"./lua/plugins/11_nvim-hlslens.lua","line_num":35,"byte_offset":23,"typo":"backware","corrections":["backward"]}
--   {"type":"binary_file","path":"./spell/en.utf-8.add.spl"}

--- Takes an array of suggested corrections (strings) and builds an output string.len
--- If the array is only one element, the output will be that string; if it's more than one,
--- the elements are joined with "or" (ex. `{"meow", "taco"}` -> `"meow or taco"`).
-- explicityly
--
---@param all_corrections table
---@return string
local function build_corrections(all_corrections)
  local corrections = ""

  if #all_corrections == 1 then
    corrections = all_corrections[1]
  else
    for _, correction in ipairs(all_corrections) do
      corrections = corrections .. " or " .. correction
    end
  end

  return corrections
end

--- Takes a table of JSON-parsed items and builds a table of `vim.diagnostic`s.
--
---@param json_items table
---@return table
local function build_diagnostics(json_items)
  local diagnostics = {}

  for _, item in ipairs(json_items) do
    if item == nil then
      return {}
    end

    local line_num = item.line_num - 1
    local corrections = build_corrections(item.corrections)

    table.insert(diagnostics, {
      lnum = line_num,
      end_lnum = line_num,
      col = item.byte_offset,
      end_col = item.byte_offset + item.type:len(),
      severity = vim.diagnostic.severity.WARN,
      source = '[typos-cli] ' .. item.type,
      message = "`" .. item.typo .. "` should be `" .. corrections .. "`"
    })
  end

  return diagnostics
end

---The main parser for nimv-lint that takes the typos-cli output and turns it into diagnostics.
---@param output string
---@param _ number
---@return table
local function typos_cli_parser(output, _)
  if output == '' then
    return {}
  end

  local json_items = {}

  -- Split the output string on newlines, where each line contains an entry of JSON.
  for json in string.gmatch(output, "[%S]+") do
    table.insert(json_items, vim.json.decode(json))
  end

  return build_diagnostics(json_items)
end

--- Provides the linter definition for nvim-dap.
--
---@return table
local function typos_cli()
  return {
    cmd = 'typos',
    stdin = true,
    append_fname = true,
    args = { "--format", "json", "-" },
    stream = "stdout",
    ignore_exitcode = true,
    env = nil,
    parser = typos_cli_parser
  }
end

return {
  'mfussenegger/nvim-lint',
  config = function()
    require('lint').linters.typos_cli = typos_cli()

    require('lint').linters_by_ft = {
      c = { 'clang-tidy' },
      cpp = { 'clang-tidy' },
      cmake = { "cmakelint", "typos_cli" },
      dockerfile = { "typos_cli" },
      git = { "typos_cli" },
      html = { "typos_cli" },
      javascript = { "typos_cli" },
      lua = { "typos_cli" },
      markdown = { 'vale', "typos_cli" },
      ruby = { "ruby", "typos_cli" },
      rust = { "typos_cli" },
      text = { "typos_cli", "vale" },
      toml = { "typos_cli" },
      typescript = { "typos_cli" },
      yaml = { "typos_cli", "yamllint" },
    }

    vim.api.nvim_create_autocmd({ "BufReadPre", "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end
}
