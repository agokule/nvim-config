return {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    keys = {
        { '<leader>gs', ':Git stage .<cr>' },
        { '<leader>gc', ':Git commit<cr>' },
        { '<leader>gu', ':Git restore .<cr>'},
        { '<leader>gP', ':Git push<cr>' },
        { '<leader>gp', ':Git pull<cr>' },
        { '<leader>g;', ':Git stage .<cr><esc><c-w>k:q<cr>:Git commit<cr>' }
    }
}
