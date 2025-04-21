return {
    'tpope/vim-sleuth',
    { 'mg979/vim-visual-multi', event = "BufRead" },
    { 'wakatime/vim-wakatime', lazy = false, event = 'VeryLazy' },
    { 'kana/vim-arpeggio', config = function ()
        vim.cmd[[
Arpeggio imap kj <Esc>
Arpeggio vmap kj <Esc>
Arpeggio cmap kj <Esc>
Arpeggio omap kj <Esc>
]]
    end, event = 'VeryLazy' },
}
