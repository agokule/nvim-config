return {
    {
        'echasnovski/mini.move',
        version = false,
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
    },
    {
        'echasnovski/mini.map',
        version = false,
        opts = function ()
            local map = require('mini.map')
            return {
                symbols = {
                    encode = map.gen_encode_symbols.dot('4x2')
                }
            }
        end,
        keys = {
            { '<leader>mc', function () MiniMap.close() end, desc = "Close MiniMap" },
            { '<leader>mf', function () MiniMap.toggle_focus() end, desc = "Toggle focus of MiniMap" },
            { '<leader>mo', function () MiniMap.open() end, desc = "Open MiniMap" },
            { '<leader>mr', function () MiniMap.refresh() end, desc = "Refresh MiniMap" },
            { '<leader>ms', function () MiniMap.toggle_side() end, desc = "Toggle side of MiniMap" },
            { '<leader>mt', function () MiniMap.toggle() end, desc = "Toggle MiniMap" },
        }
    },
    {
        'echasnovski/mini.files',
        main = 'mini.files',
        opts = {},
        keys = {
            { '<leader>:', function () MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, desc = "Open MiniFiles" },
        },
        version = '*'
    }
}
