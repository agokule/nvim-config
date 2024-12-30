return {
    "CRAG666/code_runner.nvim",
    config = true,
    opt = {
        filetype = {
            java = {
                "cd $dir &&",
                "javac $fileName &&",
                "java $fileNameWithoutExt"
            },
            python = "cd \"$dir\" && py \"$fileName\"",
            typescript = {
                "tsc $fileName ; ",
                "node $fileName",
            },
            rust = {
                "cd $dir &&",
                "rustc $fileName &&",
                "$dir/$fileNameWithoutExt"
            },
            cpp = {
                "cd \"$dir\" &&",
                "g++ -Wall -g -static -std=c++17 \"$fileName\"",
                "-o \"$fileNameWithoutExt\" &&",
                "\"$fileNameWithoutExt\""
            },
            c = {
                "cd \"$dir\" &&",
                "gcc -Wall -static -std=c17 \"$fileName\"",
                "-o \"$fileNameWithoutExt\" &&",
                "\"$fileNameWithoutExt\""
            },
            dosbatch = { -- *.bat and *.cmd files
                "cd \"$dir\" &&",
                "cmd /C \"$fileName\""
            }
        },
    },
    keys = {
        {'<leader>rc', ':RunCode<CR>', noremap = true, silent = false },
        {'<leader>rf', ':RunFile<CR>', noremap = true, silent = false },
        {'<leader>rft', ':RunFile tab<CR>', noremap = true, silent = false },
        {'<leader>rp', ':RunProject<CR>',  noremap = true, silent = false },
        {'<leader>rd', ':RunClose<CR>', noremap = true, silent = false },
        {'<leader>crf', ':CRFiletype<CR>', noremap = true, silent = false },
        {'<leader>crp', ':CRProjects<CR>', noremap = true, silent = false }
    }
}
