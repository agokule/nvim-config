return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
        { "<leader>fe", ':Neotree float<cr>', desc = "Open Neotree (FileExplorer) in float" },
    },
    cmd = { 'Neotree' },
    opts = {
        filesystem = {
            filetered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_hidden = true
            },
        },
        sources = {
            "filesystem",
            "buffers",
            "git_status",
            "document_symbols",
        },
        source_selector = {
            winbar = true,
            sources = {
                { source = "filesystem" },
                { source = "git_status" },
                { source = "document_symbols" },
            }
        },
        git_status = {
            symbols = {
                -- Change type
                added     = "✚", -- NOTE: you can set any of these to an empty string to not show them
                deleted   = "󰆴",
                modified  = "",
                renamed   = "󰁕",
                -- Status type
                untracked = "",
                ignored   = "",
                unstaged  = "",
                staged    = "",
                conflict  = "",
            },
            align = "right",
        },
    }
}
