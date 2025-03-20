local hour = tonumber(os.date('%H'))
if hour >= 7 and hour < 20 then
    vim.o.background = 'light'
    vim.cmd([[colorscheme edge]])
else
    vim.o.background = 'dark'
    vim.cmd([[colorscheme everforest]])
end
