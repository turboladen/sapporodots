local function hover()
  local filetype = vim.bo.filetype

  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand("<cword>"))
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand("<cword>"))
  else
    vim.lsp.buf.hover()
  end
end

local function make_flags()
  return {
    debounce_text_changes = 350,
  }
end

local function setup_lsp(name, lspconfig, base_capabilities)
  lspconfig[name].setup({
    capabilities = base_capabilities,
  })
end

return {
  hover = hover,
  -- make_capabilities = make_capabilities,
  make_flags = make_flags,
  setup_lsp = setup_lsp
}
