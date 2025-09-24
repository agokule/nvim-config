return {
    'aaronik/treewalker.nvim',
    opts = {},
    keys = {
        -- movement
        { '<C-k>', '<cmd>Treewalker Up<cr>', mode = { 'n', 'v' }, silent = true },
        { '<C-j>', '<cmd>Treewalker Down<cr>', mode = { 'n', 'v' }, silent = true },
        { '<C-h>', '<cmd>Treewalker Left<cr>', mode = { 'n', 'v' }, silent = true },
        { '<C-l>', '<cmd>Treewalker Right<cr>', mode = { 'n', 'v' }, silent = true },
        -- swapping
        { '<C-S-k>', '<cmd>Treewalker SwapUp<cr>', silent = true },
        { '<C-S-j>', '<cmd>Treewalker SwapDown<cr>', silent = true },
        { '<C-S-h>', '<cmd>Treewalker SwapLeft<cr>', silent = true },
        { '<C-S-l>', '<cmd>Treewalker SwapRight<cr>', silent = true },
    }
}
