return {
    'petertriho/nvim-scrollbar',
    event = "LazyFile",
    config = function()
        local colors = require("tokyonight.colors").setup()

        require("scrollbar").setup({
            handle = {
                color = colors.bg_highlight,
            },
            marks = {
                Search = { color = colors.orange },
                Error = { color = colors.error },
                Warn = { color = colors.warning },
                Info = { color = colors.info },
                Hint = { color = colors.hint },
                Misc = { color = colors.purple },
                GitAdd = { color = colors.git.add },
                GitChange = { color = colors.git.change },
                GitDelete = { color = colors.git.delete }
            }
        })
        require("scrollbar.handlers.gitsigns").setup()
    end
}
