return {
    'tpope/vim-sleuth',
    "folke/lazydev.nvim",
    { 'mbbill/undotree', keys = { { '<C-Z>', vim.cmd.UndotreeToggle } } },
    'mg979/vim-visual-multi',
    { 'm4xshen/autoclose.nvim', main = "autoclose", opts = {} },
    { 'stevearc/dressing.nvim', opts = {} },
    { 'wakatime/vim-wakatime', lazy = false },
    { 'equalsraf/neovim-gui-shim', enabled = (vim.fn.has('gui_running') and not vim.g.neovide) },
    { 'RaafatTurki/hex.nvim', opts = {} },
    { 'kana/vim-arpeggio', config = function ()
        vim.cmd[[
Arpeggio imap kj <Esc>
Arpeggio vmap kj <Esc>
Arpeggio cmap kj <Esc>
Arpeggio omap kj <Esc>
]]
    end },
    {
        "uga-rosa/ccc.nvim",
        main = 'ccc',
        keys = {
            { '<leader>cc', ':CccPick<cr>', desc = "Pick a color" },
            { '<leader>co', ':CccConvert<cr>', desc = "Convert a color between hex and rgb etc" },
        }
    },
    { 'dyng/ctrlsf.vim' }
}
