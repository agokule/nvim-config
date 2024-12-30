return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup()
        vim.keymap.set('n', '<leader>gh', ':Gitsigns preview_hunk<CR>', { desc = 'Preview git hunk' })
    end
}
