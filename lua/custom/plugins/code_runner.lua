return {
    "CRAG666/code_runner.nvim",
    config = function()
        require("code_runner").setup({
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
                    "g++ -Wall -static -std=c++17 \"$fileName\"",
                    "-o \"$fileNameWithoutExt\" &&",
                    "& \"$dir/$fileNameWithoutExt\""
                },
                c = {
                    "cd \"$dir\" &&",
                    "gcc -Wall -static \"$fileName\"",
                    "-o \"$fileNameWithoutExt\" &&",
                    "& \"$dir/$fileNameWithoutExt\""
                },
                dosbatch = { -- *.bat and *.cmd files
                    "cd \"$dir\" &&",
                    "cmd /C \"$fileName\""
                }
            },
        })
    end,
    keys = {
        {'<leader>rc', ':RunCode<CR>', noremap = true, silent = false },
        {'<leader>rf', ':RunFile<CR>', noremap = true, silent = false },
        {'<leader>rt', ':RunFile tab<CR>', noremap = true, silent = false },
        {'<leader>rp', ':RunProject<CR>',  noremap = true, silent = false },
        {'<leader>rd', ':RunClose<CR>', noremap = true, silent = false },
    }
}
