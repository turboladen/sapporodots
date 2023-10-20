local function select_next(cmp, snippy)
  return cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif snippy.can_expand_or_advance() then
      snippy.expand_or_advance()
    else
      fallback()
    end
  end, { "i", "s", "c" })
end

local function select_prev(cmp, snippy)
  return cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif snippy.can_jump(-1) then
      snippy.previous()
    else
      fallback()
    end
  end, { "i", "s", "c" })
end


return {
  select_next = select_next,
  select_prev = select_prev,
}
