-- disable osc52 bc it takes 500ms to load on my machine
vim.g.osc52 = false

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.cmd('source ' .. vim.fn.stdpath('config') .. '/more_configs.vim')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

if (vim.loop.os_uname().sysname == "Windows_NT") then
    vim.env.PATH = vim.env.PATH .. ";C:/cygwin64/bin"
end

-- i don't know how to do this in lua
vim.cmd('set autochdir')

if vim.fn.has('win32') ~= 0 then
  vim.cmd[[
    let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
    let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
    let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
    set shellquote= shellxquote=
  ]]
else
  if vim.fn.executable('zsh') ~= 0 then
    vim.o.shell = 'zsh'
  else
    vim.o.shell = 'bash'
  end
end

vim.g.enable_ai = true

if vim.g.neovide then
  -- the same color used for tokynight
  vim.g.neovide_title_background_color = "#1a1b26"
end

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  { import = 'custom.plugins', defaults = { lazy = true } },
}, {})
-- End of installing packages

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

vim.opt.scrolloff = 8

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

vim.opt.laststatus = 3

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.wrap = false

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.relativenumber = true

-- set folds to indent but disable them by default
vim.o.foldmethod = 'indent'
vim.o.foldenable = false

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<leader>tn', ':tabnew term://' .. vim.o.shell .. '<cr>', { desc = "New terminal tab (opens " .. vim.o.shell .. ')' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- These are from ThePrimeagen
vim.keymap.set('x', '<leader>p', '"_dP')

vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

vim.keymap.set('n', '<Leader>cfp', ':let @+ = expand("%:p")<CR>', { desc = "Yank Full Filepath" })
vim.keymap.set('n', '<Leader>cfr', ':let @+ = expand("%:p:.")<CR>', { desc = "Yank Relative Filepath" })
vim.keymap.set('n', '<Leader>cfn', ':let @+ = expand("%:t")<CR>', { desc = "Yank File Name" })
vim.keymap.set('n', '<Leader>cff', ':let @+ = expand("%:p:h")<CR>', { desc = "Yank File Folder" })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- temporary fix for https://github.com/neovim/neovim/issues/8587
-- taken from https://github.com/neovim/neovim/issues/8587#issuecomment-2176399196
vim.api.nvim_create_user_command("ClearShada", function()
    local shada_path = vim.fn.expand(vim.fn.stdpath('data') .. "/shada")
    local files = vim.fn.glob(shada_path .. "/*", false, true)
    local all_success = 0
    for _, file in ipairs(files) do
      local file_name = vim.fn.fnamemodify(file, ":t")
      if file_name == "main.shada" then
        -- skip your main.shada file
        goto continue
      end
      local success = vim.fn.delete(file)
      all_success = all_success + success
      if success ~= 0 then
        vim.notify("Couldn't delete file '" .. file_name .. "'", vim.log.levels.WARN)
      end
      ::continue::
    end
    if all_success == 0 then
      vim.print("Successfully deleted all temporary shada files")
    end
  end,
  { desc = "Clears all the .tmp shada files" }
)

-- I sometimes type :W instead of :w by accident
vim.api.nvim_create_user_command('W', 'w', {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
