vim.g.mkdp_auto_close = 0

vim.cmd([[
function! g:OpenUrl(url) abort
    call jobstart(['sh', '-c', 'qutebrowser --target private-window -T -C ~/.config/qutebrowser/config.py ' . shellescape(a:url)])
endfunction
]])

vim.g.mkdp_browserfunc = 'g:OpenUrl'

vim.keymap.set('n', '<leader>p', '<Plug>MarkdownPreviewToggle')
