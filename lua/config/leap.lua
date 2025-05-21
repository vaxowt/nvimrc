require('leap').add_default_mappings()

require('leap.user').set_repeat_keys('<enter>', '<backspace>', {
    -- If set to true, the keys will work like the native
    -- semicolon/comma, i.e., forward/backward is understood in
    -- relation to the last motion.
    relative_directions = false,
    modes = { 'n', 'x', 'o' },
})
