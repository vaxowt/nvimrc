require('nightfox').setup({
    options = {
        styles = {
            comments = 'italic',
        },
    },
})

local override = require('nightfox').override
override.palettes({
    dawnfox = {
        yellow = '#ba793e',
    },
})
