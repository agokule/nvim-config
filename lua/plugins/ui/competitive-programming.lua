return {
    'xeluxee/competitest.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    config = function()
        require('competitest').setup({
            testcases_use_single_file = false,
            compile_command = {
                c = { exec = "gcc", args = { "-Wall", "-static", "$(FNAME)", "-o", "$(FNOEXT)" } },
                cpp = { exec = "g++", args = { "-Wall", "-static", "$(FNAME)", "-o", "$(FNOEXT)" } },
            },
            testcases_input_file_format = "s5.$(TCNUM).in",
            testcases_output_file_format = "s5.$(TCNUM).out"
        })
    end,
    keys = {
        { '<leader>ct',  ':CompetiTest run<CR>', desc = 'Run CompetiTest' },
        { '<leader>cu',  ':CompetiTest show_ui<CR>', desc = 'Show CompetiTest ui' },
        { '<leader>crp', ':CompetiTest receive problem<CR>', desc = 'Receive problem (CompetiTest)' },
        { '<leader>crc', ':CompetiTest receive contest<CR>', desc = 'Receive contest (CompetiTest)' },
    },
}
