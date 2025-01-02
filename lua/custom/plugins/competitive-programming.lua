return {
    'xeluxee/competitest.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    config = function()
        require('competitest').setup({
            testcases_use_single_file = true,
            compile_command = {
                c = { exec = "gcc", args = { "-Wall", "-static", "$(FNAME)", "-o", "$(FNOEXT)" } },
                cpp = { exec = "g++", args = { "-Wall", "-static", "$(FNAME)", "-o", "$(FNOEXT)" } },
            }
        })
    end,
    keys = {
        { '<leader>ct',  ':CompetiTest run<CR>' },
        { '<leader>cu',  ':CompetiTest show_ui<CR>' },
        { '<leader>crp', ':CompetiTest receive problem<CR>' },
        { '<leader>crc', ':CompetiTest receive contest<CR>' },
    },
}
