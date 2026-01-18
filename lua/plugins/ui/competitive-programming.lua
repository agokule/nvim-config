return {
    'xeluxee/competitest.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    opts = {
        testcases_use_single_file = false,
        testcases_single_file_format = "$(FNAME).testcases",
        testcases_input_file_format = "s5.$(TCNUM).in",
        testcases_output_file_format = "s5.$(TCNUM).out",
        testcases_directory = './testcases/',
        runner_ui = {
            interface = 'split'
        },
        split_ui = {
            position = 'right'
        },
    },
    keys = {
        { '<leader>ct',  ':CompetiTest run<CR>', desc = 'Run CompetiTest' },
        { '<leader>cu',  ':CompetiTest show_ui<CR>', desc = 'Show CompetiTest ui' },
        { '<leader>ca',  ':CompetiTest add_testcase<CR>', desc = 'Add CompetiTest Testcase' },
        { '<leader>ce',  ':CompetiTest edit_testcase<CR>', desc = 'Edit CompetiTest Testcase' },
        { '<leader>cd',  ':CompetiTest delete_testcase<CR>', desc = 'Delete CompetiTest Testcase' },
        { '<leader>cs',  ':CompetiTest convert files_to_singlefile', desc = 'Convert multiple testcase files to single one'},
        { '<leader>cm',  ':CompetiTest convert singlefile_to_files', desc = 'Convert single testcase files to multiple ones'},
        { '<leader>crp', ':CompetiTest receive problem<CR>', desc = 'Receive problem (CompetiTest)' },
        { '<leader>crc', ':CompetiTest receive contest<CR>', desc = 'Receive contest (CompetiTest)' },
    },
    cmd = { 'CompetiTest' }
}
