return {
    'lewis6991/gitsigns.nvim',
    opts = {
        current_line_blame_formatter = "        <author>, <summary> • <author_time:%R> • <abbrev_sha>",
        current_line_blame_formatter_nc = "        Not commited yet"
    },
    keys = {
        { '<leader>hs', function () require('gitsigns').stage_hunk() end, desc = 'Stage git hunk' },
        { '<leader>hr', function () require('gitsigns').reset_hunk() end, desc = 'Reset git hunk' },

        { '<leader>hs', function () require('gitsigns').stage_hunk({vim.fn.line('.'), vim.fn.line('v')}) end, mode = 'v', desc = 'Stage git hunk' },
        { '<leader>hr', function () require('gitsigns').reset_hunk({vim.fn.line('.'), vim.fn.line('v')}) end, mode = 'v', desc = 'Reset git hunk' },

        { 'ih', function () require('gitsigns').select_hunk() end, mode = { 'o', 'x' }, desc = 'Select git hunk' },
        { 'ah', function () require('gitsigns').select_hunk() end, mode = { 'o', 'x' }, desc = 'Select git hunk' },

        { '<leader>bs', function () require('gitsigns').stage_buffer() end, desc = 'Stage git buffer' },
        { '<leader>br', function () require('gitsigns').reset_buffer() end, desc = 'Reset git buffer' },
        { '<leader>bu', function () require('gitsigns').reset_buffer_index() end, desc = 'Unstage git buffer' },

        { '<leader>gh', function () require('gitsigns').preview_hunk() end, desc = 'Preview git hunk' },
        { '<leader>gw', function () require('gitsigns').show() end, desc = 'Show file as it is on github' },
        { '<leader>gj', function () require('gitsigns').nav_hunk('next') end, desc = 'Next git hunk' },
        { '<leader>gk', function () require('gitsigns').nav_hunk('prev') end, desc = 'Previous git hunk' },
        { '<leader>ga', function () require('gitsigns').blame() end, desc = 'Show git blame' },

        { '<leader>ugl', function () require('gitsigns').toggle_linehl() end, desc = 'Toggle current line git highlight' },
        { '<leader>ugn', function () require('gitsigns').toggle_numhl() end, desc = 'Toggle current line number git highlight' },
        { '<leader>ugb', function () require('gitsigns').toggle_current_line_blame() end, desc = 'Toggle current line git blame' },
    },
    event = 'LazyFile'
}
