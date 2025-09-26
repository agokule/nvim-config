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
                -- Add languages to be installed here that you want installed for treesitter
                ensure_installed = { 'lua', 'python', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'html', 'css' },

                -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
                auto_install = false,

                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                        scope_incremental = '<c-s>',
                        node_decremental = '<s-space>',
                    },
                },
            }
        end, 0)
    end,
}
