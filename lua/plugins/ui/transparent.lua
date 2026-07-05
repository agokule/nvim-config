---@type LazySpec
return {
    "xiyaowong/transparent.nvim",
    cond = not vim.g.neovide,
    opts = {
        on_clear = function ()
            require('transparent').clear_prefix('MiniStatusline')
        end
    },
    cmd = {
        "TransparentEnable",
        "TransparentDisable",
        "TransparentToggle"
    },
    keys = {
        { "<leader>uB", ':TransparentToggle<cr>', desc = "Toggle transparency" }
    }
}
