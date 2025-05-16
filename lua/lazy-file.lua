-- Creates the LazyFile
-- This should have the same effect as the LazyFile event in LazyVim
-- It seems most of this code was removed from LazyVim in the following github commit
-- https://github.com/LazyVim/LazyVim/commit/965a469ca8cb1d58b49c4e5d8b85430e8c6c0a25

local lazy_event = require('lazy.core.handler.event')
lazy_event.mappings.LazyFile = { id = "LazyFile", event = "User", pattern = "LazyFile" }
lazy_event.mappings['User LazyFile'] = lazy_event.mappings.LazyFile

local lazy_file_events = { "BufRead", "BufNewFile", "BufWritePre"}

local done = false

local function load()
  if done then return end
  done = true
  vim.api.nvim_exec_autocmds("User", { pattern = "LazyFile", modeline = false })
end

-- schedule wrap so that nested autocmds are executed
-- and the UI can continue rendering without blocking
load = vim.schedule_wrap(load)

vim.api.nvim_create_autocmd(lazy_file_events, {
  group = vim.api.nvim_create_augroup("lazy_file", { clear = true }),
  callback = function()
    load()
  end,
})

