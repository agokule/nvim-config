return {
    "Exafunction/codeium.nvim",
    enabled = vim.g.enable_ai,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    event = "LazyFile",
    opts = {
        -- Optionally disable cmp source if using virtual text only
        enable_cmp_source = true,
        enable_chat = true,
        virtual_text = {
            enabled = true,
        }
    }
}
