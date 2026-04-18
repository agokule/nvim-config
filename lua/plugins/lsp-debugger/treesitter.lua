return {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = "LazyFile",
    config = function()
        -- [[ Configure Treesitter ]]
        -- See `:help nvim-treesitter`
        -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
        vim.defer_fn(function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    -- Add languages to be installed here that you want installed for treesitter
                    'lua', 'python', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'html', 'css',
                    'cpp', 'c'
                }
            }
        end, 0)
    end,
}
