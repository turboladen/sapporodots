local function strip_tabs()
  vim.opt_local.expandtab = true
  vim.cmd("retab")
end

---Make an adapted box with left-aligned text, then format.
--
---@param style number
local function al_box(style)
  require("comment-box").albox(style)
  vim.lsp.buf.format({ async = false })
end

---Make an centered box with centered text, then format. Good for file headers.
--
---@param style number
local function cc_box(style)
  style = style or 3
  require("comment-box").ccbox(style)
  vim.lsp.buf.format({ async = false })
end

return {
  al_box = al_box,
  cc_box = cc_box,
  signs = { Error = " ", Warn = " ", Hint = " ", Info = " " },
  strip_tabs = strip_tabs
}
