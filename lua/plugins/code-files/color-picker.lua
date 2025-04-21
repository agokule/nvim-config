return {
    "uga-rosa/ccc.nvim",
    main = 'ccc',
    opts = {},
    keys = {
        { '<leader>cc', ':CccPick<cr>',    desc = "Pick a color" },
        { '<leader>co', ':CccConvert<cr>', desc = "Convert a color between hex and rgb etc" },
    }
}
