local function test_nearest()
  local neotest = require('neotest')

  neotest.run.run()
  neotest.output_panel.open()
end

local function debug_nearest()
  local neotest = require('neotest')

  neotest.run.run({ strategy = 'dap' })

  neotest.output.open({ enter = true })
  neotest.summary.open()
end

local function test_current_file()
  local neotest = require('neotest')

  neotest.run.run(vim.fn.expand("%"))

  neotest.output_panel.open()
  neotest.summary.open()
end

return {
  test_nearest = test_nearest,
  debug_nearest = debug_nearest,
  test_current_file = test_current_file
}
