return {
    "ziontee113/icon-picker.nvim",
    main = "icon-picker",
    opts = { disable_legacy_commands = true },
    keys = {
        { "<Leader>si", "<cmd>IconPickerNormal<cr>", desc = "Search and insert Icons", noremap = true, silent = true },
        { "<Leader>sy", "<cmd>IconPickerYank<cr>", desc = "Search and yank Icons", noremap = true, silent = true },
        { "<C-l>", "<cmd>IconPickerInsert<cr>", mode = "i", desc = "Search Icons", noremap = true, silent = true },
    }
}
