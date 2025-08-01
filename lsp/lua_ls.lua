return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  settings = {
    Lua = {
      runtime = {
         -- Tell the language server which version of Lua you're using (most
         -- likely LuaJIT in the case of Neovim)
         version = 'LuaJIT',
         -- Tell the language server how to find Lua modules same way as Neovim
         -- (see `:h lua-module-load`)
         path = {
           'lua/?.lua',
           'lua/?/init.lua',
         },
      },
       -- Make the server aware of Neovim runtime files
      workspace = {
         checkThirdParty = false,
         library = {
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          library = vim.tbl_filter(function(d)
            return not d:match(vim.fn.stdpath('config') .. '/?a?f?t?e?r?')
          end, vim.api.nvim_get_runtime_file('', true))
           -- Depending on the usage, you might want to add additional paths
           -- here.
           -- '${3rd}/luv/library'
           -- '${3rd}/busted/library'
        }
       }
    }
  }
}
