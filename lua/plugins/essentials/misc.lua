return {
    'tpope/vim-sleuth',
    { 'kana/vim-arpeggio', config = function ()
        vim.cmd[[
Arpeggio imap kj <Esc>
Arpeggio vmap kj <Esc>
Arpeggio cmap kj <Esc>
Arpeggio omap kj <Esc>
]]
    end, event = 'VeryLazy' },
}
