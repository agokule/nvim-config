-- disable osc52 bc it doesn't work
local termfeatures = vim.g.termfeatures or {}
termfeatures.osc52 = false
vim.g.termfeatures = termfeatures

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('local-settings')

if vim.fn.has('win32') ~= 0 then
  -- see `:h shell-powershell` for more info
  vim.cmd[[
	   set noshelltemp
	   let &shell = 'pwsh'
	   let &shellcmdflag .= '$PSStyle.OutputRendering = ''PlainText'';'
	   " Workaround (may not be needed in future version of pwsh):
	   let $__SuppressAnsiEscapeSequences = 1
	   let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
	   let &shellcmdflag .= '[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();'
	   let &shellcmdflag .= '$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';'
	   let &shellpipe  = '> %s 2>&1'
	   set shellquote= shellxquote=
  ]]
else
  if vim.fn.executable('zsh') ~= 0 then
    vim.o.shell = 'zsh'
  else
    vim.o.shell = 'bash'
  end
end

if vim.g.neovide then
  -- the same color used for tokynight
  vim.g.neovide_title_background_color = "#1a1b26"
end

-- needed so that neovide ignores the system theme
vim.o.background = 'dark'

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

require('lazy-file')

require('lazy').setup({
  { import = 'plugins.essentials' },
  { import = 'plugins.lsp-debugger', cond = (not vim.g.vscode) },
  { import = 'plugins.code-files' },
  { import = 'plugins.ai', cond = (vim.g.enable_ai and not vim.g.vscode) },
  { import = 'plugins.ui', cond = (not vim.g.vscode) },
  { import = 'plugins.git', cond = (not vim.g.vscode) },
}, {})

-- I sometimes type :W instead of :w by accident
vim.api.nvim_create_user_command('W', 'w', {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
