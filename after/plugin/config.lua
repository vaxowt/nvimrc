local hour = tonumber(os.date('%H'))
if hour >= 7 and hour < 20 then
    vim.cmd([[colorscheme edge]])
    vim.o.background = 'light'
else
    vim.cmd([[colorscheme everforest]])
    vim.o.background = 'dark'
end
