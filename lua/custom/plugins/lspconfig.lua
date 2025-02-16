local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
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
    nmap('K', vim.lsp.with(vim.lsp.buf.hover, { border = "single" }), 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

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
        event = "BufEnter",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            { 'j-hui/fidget.nvim', opts = {} },
        },
    },
    {
        'williamboman/mason-lspconfig.nvim',
        event = "BufEnter",
        dependencies = { 'williamboman/mason.nvim' },
        opts = {
            ensure_installed = vim.tbl_keys(servers),
        }
    },
    {
        'williamboman/mason.nvim',
        event = "BufEnter",
        config = function ()
            -- mason-lspconfig requires that these setup functions are called in this order
            -- before setting up the servers.
            require('mason').setup()

            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            -- Ensure the servers above are installed
            local mason_lspconfig = require 'mason-lspconfig'

            mason_lspconfig.setup_handlers {
                function(server_name)
                    if server_name == 'clangd' then
                        require('lspconfig').clangd.setup {
                            on_attach = function(client, bufnr)
                                if server_name == 'clangd' then
                                    client.server_capabilities.signatureHelpProvider = false
                                end
                                on_attach(client, bufnr)
                            end,
                            cmd = {
                                vim.fn.stdpath("data") .. "\\mason\\bin\\clangd.cmd",
                                "--function-arg-placeholders=0",
                                "--completion-style=detailed"
                            }
                        }
                        return
                    end
                    require('lspconfig')[server_name].setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    }
                end,
            }
        end
    }
}
