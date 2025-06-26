return {
    "Exafunction/windsurf.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    event = "InsertEnter",
    main = "codeium",
    opts = {
        -- Optionally disable cmp source if using virtual text only
        enable_cmp_source = true,
        enable_chat = true,
        virtual_text = {
            enabled = true,
            key_bindings = {
                accept = "<s-tab>"
            }
        }
    }
}
