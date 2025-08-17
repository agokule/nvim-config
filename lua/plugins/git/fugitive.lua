return {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    keys = {
        { '<leader>gs', ':Git stage .<cr>', remap = true },
        { '<leader>gc', ':Git commit<cr>', remap = true },
        { '<leader>gu', ':Git restore .<cr>'},
        { '<leader>gP', ':Git push<cr>' },
        { '<leader>gp', ':Git pull<cr>' },
        { '<leader>g;', ':Git stage .<cr><esc><c-w>k:q<cr>:Git commit<cr>' }
    }
}
