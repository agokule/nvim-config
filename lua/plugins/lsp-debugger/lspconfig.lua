local servers = {
  clangd = {},
  pylsp = {},
  html = {
    filetypes = {
      'html', 'twig', 'hbs'
    }
  },

  lua_ls = {
    Lua = {
      workspace = {
        checkThirdParty = true,
        library = " ${3rd}/luv/library"
      },
      telemetry = { enable = false },
    },
  },
}

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    -- See `:help K` for why this keymap
    nmap('K', function () vim.lsp.buf.hover({ border = "rounded" }) end, 'Hover Documentation')
    nmap('<C-k>', function() vim.lsp.buf.signature_help({ border = "rounded" }) end, 'Signature Documentation')

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


return {
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        event = "LazyFile",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
    },
    {
        'williamboman/mason-lspconfig.nvim',
        event = "LazyFile",
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            require("mason-lspconfig").setup { ensure_installed = vim.tbl_keys(servers) }

            for server_name, server_config in pairs(servers) do
                local config = { on_attach = on_attach }
                vim.lsp.config(server_name, config)
                if server_name == "clangd" then
                    vim.lsp.config(server_name, {
                        cmd = { "clangd", "--completion-style=detailed" }
                    })
                end
                vim.lsp.enable(server_name)
            end
        end
    },
    {
        'williamboman/mason.nvim',
        event = "LazyFile",
        opts = {}
    }
}
