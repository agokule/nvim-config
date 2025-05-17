return {
    "Exafunction/codeium.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    event = "InsertEnter",
    opts = {
        -- Optionally disable cmp source if using virtual text only
        enable_cmp_source = true,
        enable_chat = true,
        virtual_text = {
            enabled = true,
        }
    }
}
