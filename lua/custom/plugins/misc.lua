return {
    'tpope/vim-sleuth',
    "folke/lazydev.nvim",
    { 'mbbill/undotree', keys = { { '<C-Z>', vim.cmd.UndotreeToggle } } },
    'mg979/vim-visual-multi',
    { 'm4xshen/autoclose.nvim', main = "autoclose", opts = {} },
    { 'stevearc/dressing.nvim', opts = {} },
    { 'wakatime/vim-wakatime', lazy = false },
    'equalsraf/neovim-gui-shim',
    'RaafatTurki/hex.nvim',
    { 'github/copilot.vim', enabled = false },
    { 'kana/vim-arpeggio', config = function ()
        vim.cmd[[
Arpeggio imap jk <Esc> " input ESC when jk is pressed
Arpeggio vmap jk <Esc> " input ESC when jk is pressed
Arpeggio cmap kj <Esc> " input ESC when kj is pressed
Arpeggio omap kj <Esc> " input ESC when kj is pressed
]]
    end },
}
