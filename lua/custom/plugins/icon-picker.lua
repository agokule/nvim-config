return {
    "ziontee113/icon-picker.nvim",
    config = function()
        require("icon-picker").setup({ disable_legacy_commands = true })

        vim.keymap.set("n", "<Leader>si", "<cmd>IconPickerNormal<cr>",
            { noremap = true, silent = true, desc = "Search and insert Icons" })
        vim.keymap.set("n", "<Leader>sy", "<cmd>IconPickerYank<cr>",
            { noremap = true, silent = true, desc = "Search and yank Icons" })                                                            --> Yank the selected icon into register
        vim.keymap.set("i", "<C-i>", "<cmd>IconPickerInsert<cr>",
            { noremap = true, silent = true, desc = "Search Icons" })
    end
}
