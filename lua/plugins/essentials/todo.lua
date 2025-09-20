return {
    'agokule/floatingtodo.nvim',
    opts = {
        position = 'topright'
    },
    keys = {
        { '<leader>tl', ':TodoLocal<cr>' },
        { '<leader>th', ':TodoGlobal<cr>' },
    }
}
