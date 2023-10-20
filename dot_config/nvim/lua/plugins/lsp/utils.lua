local function make_capabilities(capabilities)
  vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities(),
    require("lsp-status").capabilities,
    capabilities or {}
  )
end

return {
  make_capabilities = make_capabilities
}
