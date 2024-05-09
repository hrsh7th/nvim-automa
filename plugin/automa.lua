vim.api.nvim_create_user_command('AutomaToggleDebugger', function()
  require('automa').toggle_debug_panel()
end, {})

