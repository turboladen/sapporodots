local function is_empty(s)
  return s == nil or s == ""
end

local function prefix()
  if not is_empty(vim.g.turboladen_homebrew_prefix) then
    return vim.g.turboladen_homebrew_prefix
  end

  local Job = require("plenary.job")

  Job
      :new({
        command = "brew",
        args = { "--prefix" },
        env = { ["PATH"] = vim.env.PATH },
        on_exit = function(j, return_val)
          if return_val == 0 then
            vim.g.turboladen_homebrew_prefix = j:result()[1]
          else
            print("Unable to determine homebrew prefix")
          end
          return vim.g.turboladen_homebrew_prefix
        end,
      })
      :sync()
end

return {
  prefix = prefix,
}
