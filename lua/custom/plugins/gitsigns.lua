return {
    'lewis6991/gitsigns.nvim',
    opts = {
        current_line_blame = true,
        current_line_blame_formatter = "        <author>, <summary> • <author_time:%R> • <abbrev_sha>",
        current_line_blame_formatter_nc = "        Not commited yet"
    },
    keys = {
        { '<leader>gh', ':Gitsigns preview_hunk<CR>', desc = 'Preview git hunk' }
    },
    event = 'BufRead'
}
