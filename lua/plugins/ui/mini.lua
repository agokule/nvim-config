return {
    'echasnovski/mini.files',
    main = 'mini.files',
    opts = {},
    keys = {
        { '<leader>:', function () MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, desc = "Open MiniFiles" },
    },
    version = '*'
}
