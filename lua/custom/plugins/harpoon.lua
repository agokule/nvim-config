return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = 'UIEnter',
    config = function ()
        local harpoon = require("harpoon")
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true
            }
        })

        vim.keymap.set('n', '<leader>fa', function() harpoon:list():add() end, { desc = 'Add file to harpoon' })
        vim.keymap.set('n', '<leader>fs', function() harpoon:list():remove() end, { desc = 'Remove file from harpoon' })
        vim.keymap.set('n', '<leader>fj', function() harpoon:list():select(1) end, { desc = 'Select harpoon file 1' })
        vim.keymap.set('n', '<leader>fk', function() harpoon:list():select(2) end, { desc = 'Select harpoon file 2' })
        vim.keymap.set('n', '<leader>fl', function() harpoon:list():select(3) end, { desc = 'Select harpoon file 3' })
        vim.keymap.set('n', '<leader>f;', function() harpoon:list():select(4) end, { desc = 'Select harpoon file 4' })
        vim.keymap.set('n', '<leader>fJ', function() harpoon:list():select(5) end, { desc = 'Select harpoon file 5' })
        vim.keymap.set('n', '<leader>fK', function() harpoon:list():select(6) end, { desc = 'Select harpoon file 6' })
        vim.keymap.set('n', '<leader>fL', function() harpoon:list():select(7) end, { desc = 'Select harpoon file 7' })
        vim.keymap.set('n', '<leader>f:', function() harpoon:list():select(8) end, { desc = 'Select harpoon file 8' })
        vim.keymap.set('n', '<leader>fo', function() harpoon:list():prev() end, { desc = 'Go to previous harpoon file' })
        vim.keymap.set('n', '<leader>fp', function() harpoon:list():next() end, { desc = 'Go to next harpoon file' })

        vim.keymap.set("n", "<leader>fd", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Open harpoon window" })
    end
}
