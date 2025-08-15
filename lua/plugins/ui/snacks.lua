-- if on windows, use py instead of python3
local superheroyrr_cmd
if vim.fn.has("win32") == 1 then
    superheroyrr_cmd = "py " .. vim.fn.stdpath("config") .. "/superheroyrr.py"
else
    superheroyrr_cmd = "python3 " .. vim.fn.stdpath("config") .. "/superheroyrr.py"
end

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            sections = {
                { section = "header" },
                { icon = "󰌌 ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
                { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                {
                    pane = 2,
                    section = "terminal",
                    cmd = superheroyrr_cmd,
                    height = 10,
                    padding = 1,
                    align = "center",
                    indent = 25
                },
                {
                    pane = 2,
                    icon = " ",
                    desc = "Browse Repo",
                    padding = 1,
                    key = "b",
                    action = function()
                        Snacks.gitbrowse()
                    end,
                },
                function()
                    local in_git = Snacks.git.get_root() ~= nil
                    local cmds = {
                        {
                            title = "Notifications",
                            cmd = "gh status",
                            action = function()
                                vim.ui.open("https://github.com/notifications")
                            end,
                            key = "s",
                            icon = " ",
                            height = 5,
                            enabled = true,
                        },
                        {
                            title = "Open Issues",
                            cmd = "gh issue list -L 3",
                            key = "i",
                            action = function()
                                vim.fn.jobstart("gh issue list --web", { detach = true })
                            end,
                            icon = " ",
                            height = 5,
                        },
                        {
                            icon = " ",
                            title = "Open PRs",
                            cmd = "gh pr list -L 3",
                            key = "p",
                            action = function()
                                vim.fn.jobstart("gh pr list --web", { detach = true })
                            end,
                            height = 5,
                        },
                        {
                            icon = " ",
                            title = "Git Status",
                            cmd = "git --no-pager diff --stat -B -M -C",
                            height = 7,
                        },
                    }
                    return vim.tbl_map(function(cmd)
                        return vim.tbl_extend("force", {
                            pane = 2,
                            section = "terminal",
                            enabled = in_git,
                            padding = 1,
                            ttl = 5 * 60,
                            indent = 3,
                        }, cmd)
                    end, cmds)
                end,
                { section = "startup" },
            },
        },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 6000,
        },
        quickfile = { enabled = true },
        scroll = { enabled = not vim.g.neovide },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        -- scope = { enabled = true },
        styles = {
            notification = {
                border = "rounded",
                zindex = 100,
                ft = "markdown",
                wo = {
                    winblend = 5,
                    wrap = false,
                    conceallevel = 2,
                    colorcolumn = "",
                },
                bo = { filetype = "snacks_notif" },
                relative = "editor"
            }
        },
        picker = {}
    },
    keys = {
        { "<leader>z",  function() Snacks.zen() end,                     desc = "Toggle Zen Mode" },
        { "<leader>Z",  function() Snacks.zen.zoom() end,                desc = "Toggle Zoom" },
        { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
        { "<leader>n",  function() Snacks.notifier.show_history() end,   desc = "Notification History" },
        { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
        { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
        { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse",                  mode = { "n", "v" } },
        { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
        { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
        { "<leader>lg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
        { "<leader>lG", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
        { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
        { "<c-/>",      function() Snacks.terminal() end,                desc = "Toggle Terminal" },
        { "<c-_>",      function() Snacks.terminal() end,                desc = "which_key_ignore" },
        { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",              mode = { "n", "t" } },
        { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",              mode = { "n", "t" } },
        {
            "<leader>N",
            desc = "Neovim News",
            function()
                Snacks.win({
                    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                    width = 0.6,
                    height = 0.6,
                    wo = {
                        spell = false,
                        wrap = false,
                        signcolumn = "yes",
                        statuscolumn = " ",
                        conceallevel = 3,
                    },
                })
            end,
        },
        -- Top Pickers & Explorer
        { "<leader>?", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
        { "<leader><space>", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>s:", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>sn", function() Snacks.picker.notifications() end, desc = "Search Notification History" },
        -- find
        { "<leader>sg", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>sf", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>sp", function() Snacks.picker.projects() end, desc = "Projects" },
        { "<leader>sr", function() Snacks.picker.recent() end, desc = "Recent" },
        -- git
        { "<leader>gr", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
        { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
        { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
        { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
        -- Grep
        { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
        { "<leader>sb", function() Snacks.picker.grep() end, desc = "Grep all files" },
        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
        { "<leader>s?", function()
            -- get all documentation directories
            local docs = {}
            for _, dir in ipairs(vim.api.nvim_get_runtime_file("doc", true)) do
                if vim.fn.isdirectory(dir) == 1 then
                    table.insert(docs, dir)
                end
            end
            Snacks.picker.grep({ dirs = docs, previewers = { file = { ft = "help" } } })
        end, desc = "Grep help" },
        -- search
        { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
        { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
        { "<leader>sC", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
        { "<leader>/", function() Snacks.picker.lines({ layout = { preset = "ivy" }}) end, desc = "Buffer Lines" },
        { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
        { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
        { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
        { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
        { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
        { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
        { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
        { "<leader>se", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
        { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
        { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
        { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
        -- LSP
        { "<F12>", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        { "<leader>ds", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
        { "<leader>dS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
        { "<leader>ts", function () Snacks.picker.treesitter() end, desc = "Treesitter symbols" }
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                "<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
                Snacks.toggle.indent():map("<leader>uG")
                Snacks.toggle.dim():map("<leader>uD")

                -- LSP Progress
                Snacks.toggle.new({
                    name = "LSP Progress",
                    id = "lsp_progress",
                    get = function() return vim.g.lsp_progress end,
                    set = function(state) vim.g.lsp_progress = state end
                }):map("<leader>up")

                -- animations (either neovide or snacks-animate)
                if (vim.g.neovide) then
                    vim.g.default_cursor_animation_length = vim.g.neovide_cursor_animation_length
                    vim.g.default_position_animation_length = vim.g.neovide_position_animation_length
                    vim.g.default_scroll_animation_length = vim.g.neovide_scroll_animation_length
                end
                Snacks.toggle.new({
                    id = "animations",
                    name = "Animations",
                    get = function()
                        if not vim.g.neovide then
                            return vim.g.snacks_animate ~= false
                        else
                            return vim.g.neovide_cursor_animation_length ~= 0
                        end
                    end,
                    set = function(state)
                        if not vim.g.neovide then
                            vim.g.snacks_animate = state
                        end

                        if state then
                            vim.g.neovide_cursor_animation_length = vim.g.default_cursor_animation_length
                            vim.g.neovide_position_animation_length = vim.g.default_position_animation_length
                            vim.g.neovide_scroll_animation_length = vim.g.default_scroll_animation_length
                        else
                            vim.g.neovide_cursor_animation_length = 0
                            vim.g.neovide_position_animation_length = 0
                            vim.g.neovide_scroll_animation_length = 0
                        end
                    end,
                }):map("<leader>ua")

                if vim.g.neovide then
                    Snacks.toggle.new({
                        id = 'fullscreen',
                        name = 'Fullscreen Mode',
                        get = function() return vim.g.neovide_fullscreen end,
                        set = function(state) vim.g.neovide_fullscreen = state end
                    }):map('<F11>'):map('<leader>fs')
                end
            end,
        })
    end,
}
