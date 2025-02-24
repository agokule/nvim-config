return {
    'tpope/vim-sleuth',
    { 'mbbill/undotree', keys = { { '<C-Z>', vim.cmd.UndotreeToggle, desc = "Toggle undotree" } } },
    { 'mg979/vim-visual-multi', event = "BufRead" },
    { 'm4xshen/autoclose.nvim', event = "InsertEnter", main = "autoclose", opts = {} },
    { 'wakatime/vim-wakatime', lazy = false, event = 'UIEnter' },
    { 'equalsraf/neovim-gui-shim', enabled = (vim.fn.has('gui_running') and not vim.g.neovide) },
    { 'RaafatTurki/hex.nvim', opts = {}, cmd = { "HexToggle", "HexDump", "HexAssemble" } },
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
        opts = {},
        keys = {
            { '<leader>cc', ':CccPick<cr>', desc = "Pick a color" },
            { '<leader>co', ':CccConvert<cr>', desc = "Convert a color between hex and rgb etc" },
        }
    },
}
