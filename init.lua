-- disable osc52 bc it doesn't work
local termfeatures = vim.g.termfeatures or {}
termfeatures.osc52 = false
vim.g.termfeatures = termfeatures

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.cmd('source ' .. vim.fn.stdpath('config') .. '/more_configs.vim')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

if (vim.fn.has('win32')) then
  vim.env.PATH = vim.env.PATH .. ";C:/cygwin64/bin"
  -- check if c:/cygwin64/bin exists
  if (vim.fn.isdirectory('C:/cygwin64/bin') == 0) then
    vim.notify("C:/cygwin64/bin does not exist", vim.log.levels.WARN)
  end
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

require('lazy').setup({
  { import = 'plugins.essentials' },
  { import = 'plugins.lsp-debugger', enabled = (not vim.g.vscode) },
  { import = 'plugins.code-files' },
  { import = 'plugins.ai', enabled = (vim.g.enable_ai and not vim.g.vscode) },
  { import = 'plugins.ui', enabled = (not vim.g.vscode) },
  { import = 'plugins.git', enabled = (not vim.g.vscode) },
}, {})

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

vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { desc = 'Escape terminal mode' })

vim.keymap.set('i', '<C-BS>', '<C-W>', { desc = 'Delete the previous word in insert mode' })

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
vim.keymap.set('n', '[d', function ()
  vim.diagnostic.jump({ diagnostic = vim.diagnostic.get_prev() })
end, { desc = 'Go to previous diagnostic message' })

vim.keymap.set('n', ']d', function ()
  vim.diagnostic.jump({ diagnostic = vim.diagnostic.get_next() })
end, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Helper function to toggle diagnostic display options
local function toggle_diagnostic_display(option_name)
  local current_config = vim.diagnostic.config()[option_name]
  local is_enabled = current_config ~= false
  local is_current_line_only = type(current_config) == "table" and current_config.current_line == true

  if is_enabled then
    if is_current_line_only then
      -- If currently enabled for current line only, turn it off completely
      vim.notify("Disabled diagnostic " .. option_name .. " completely", vim.log.levels.INFO)
      vim.diagnostic.config({ [option_name] = false })
    else
      -- If currently enabled for all lines, change to current line only
      vim.notify("Enabled diagnostic " .. option_name .. " for current line only", vim.log.levels.INFO)
      vim.diagnostic.config({ [option_name] = { current_line = true } })
    end
  else
    -- If currently disabled, enable for all lines
    vim.notify("Enabled diagnostic " .. option_name .. " for all lines", vim.log.levels.INFO)
    vim.diagnostic.config({ [option_name] = true })
  end
end

vim.keymap.set('n', 'gdl', function() toggle_diagnostic_display("virtual_lines") end, { desc = 'Toggle diagnostic virtual_lines' })
vim.keymap.set('n', 'gdt', function() toggle_diagnostic_display("virtual_text") end, { desc = 'Toggle diagnostic virtual_text' })
vim.keymap.set('n', 'gdd', function () vim.diagnostic.open_float({ border = "rounded" }) end, { desc = 'Open diagnostic float' })

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
