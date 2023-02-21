require('codewindow').setup({})

vim.api.nvim_create_user_command('Minimap', require('codewindow').toggle_minimap, {})
