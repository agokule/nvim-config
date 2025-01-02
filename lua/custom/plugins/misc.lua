return {
    'tpope/vim-sleuth',
    "folke/lazydev.nvim",
    { 'mbbill/undotree', keys = { { '<C-Z>', vim.cmd.UndotreeToggle } } },
    'mg979/vim-visual-multi',
    'm4xshen/autoclose.nvim',
    'stevearc/dressing.nvim',
    { 'wakatime/vim-wakatime', lazy = false },
    'equalsraf/neovim-gui-shim',
    'RaafatTurki/hex.nvim',
    'github/copilot.vim',
    { 'kana/vim-arpeggio', config = function ()
        vim.cmd[[
Arpeggio map jk <Esc> " input ESC when jk is pressed
Arpeggio cmap kj <Esc> " input ESC when kj is pressed
]]
    end }
}
