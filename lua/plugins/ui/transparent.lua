return {
    "xiyaowong/transparent.nvim",
    cond = not vim.g.neovide,
    opts = {},
    cmd = {
        "TransparentEnable",
        "TransparentDisable",
        "TransparentToggle"
    },
    keys = {
        { "<leader>uB", ':TransparentToggle<cr>', desc = "Toggle transparency" }
    }
}
