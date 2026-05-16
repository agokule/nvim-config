vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local nmap = function(keys, func, desc, imap)
            if desc then
                desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            if imap then
                vim.keymap.set('i', keys, func, { buffer = bufnr, desc = desc })
            end
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- See `:help K` for why this keymap
        nmap('K', function () vim.lsp.buf.hover({ border = "rounded" }) end, 'Hover Documentation')
        nmap('<C-k>', function() vim.lsp.buf.signature_help({ border = "rounded" }) end, 'Signature Documentation', true)

        -- Lesser used LSP functionality
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
    end
})

vim.keymap.set('n', '<leader>ui', function()
    local lsps = {
        "clangd",
        "emmet_language_server",
        "lua_ls",
        "pyright",
        "ts_ls",
    }
    local choices = {}
    for _, name in ipairs(lsps) do
        if vim.lsp.is_enabled(name) then
            table.insert(choices, " " .. name)
        else
            table.insert(choices, name)
        end
    end
    vim.ui.select(choices, {
        prompt = "Select lsp to enabled/disable"
    }, function(choice, idx)
        if choice == nil then
            return
        end
        vim.lsp.enable(lsps[idx], not vim.lsp.is_enabled(lsps[idx]))
    end)
end)

-- Creates a progress bar for LSP loading
vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        if not vim.g.lsp_progress then return end

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.api.nvim_echo({
            { ev.data.params.value.kind == "end" and " "
            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1] },
            { vim.lsp.status() }
        }, true, {
            kind = 'progress',
            status = ev.data.params.value.kind == "end" and "success" or "running",
            percent = ev.data.params.value.percentage or 100,
            title = 'Loading LSP',
            id = 'lsp-loading',
            source = 'lsp-loading'
        })
    end,
})
