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
    {
        "kelly-lin/telescope-ag",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            local telescope_ag = require("telescope-ag")
            telescope_ag.setup()

            vim.keymap.set('n', '<leader>sa', function ()
                vim.ui.input({ prompt = "Enter your search query: " }, function (inp)
                    if inp and inp ~= "" then
                        vim.cmd("Ag " .. inp)
                    end
                end)
            end, { desc = "[S]earch by [A]g"})
        end
    }
}
