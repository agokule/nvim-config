return {
    'echasnovski/mini.move',
    version = false,
    enabled = false,
    opts = {
        mappings = {
            -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
            left = '<',
            right = '>',
            down = 'J',
            up = 'K',
        }
    },
    event = 'VeryLazy'
}
