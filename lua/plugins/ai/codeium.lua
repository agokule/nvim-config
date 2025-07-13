return {
    "Exafunction/windsurf.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    enabled = false,
    event = "InsertEnter",
    main = "codeium",
    opts = function()
        -- temporarary fix for Windows newline handling error
        -- https://github.com/Exafunction/windsurf.nvim/issues/168
        if vim.fn.has('win32') == 1 then
            require('codeium.util').get_newline = function ()
                return "\n"
            end
        end
        return {
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
    end
}
