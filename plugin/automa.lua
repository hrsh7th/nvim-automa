vim.api.nvim_create_user_command('AutomaToggleDebugger', function()
  require('automa').toggle_debug_panel()
end, {})

vim.api.nvim_create_user_command('AutomaSave', function(params)
  require('automa').save(params.args or 'annoymous')
end, {
  nargs = '*'
})
