-- Creates the LazyFile and UIDone events
-- LazyFile event here should have the same effect as the LazyFile event in LazyVim
-- It seems most of this code was removed from LazyVim in the following github commit
-- https://github.com/LazyVim/LazyVim/commit/965a469ca8cb1d58b49c4e5d8b85430e8c6c0a25

local lazy_event = require('lazy.core.handler.event')
lazy_event.mappings.LazyFile = { id = "LazyFile", event = "User", pattern = "LazyFile" }
lazy_event.mappings['User LazyFile'] = lazy_event.mappings.LazyFile

lazy_event.mappings.UIDone = { id = "UIDone", event = "User", pattern = "UIDone" }
lazy_event.mappings['User UIDone'] = lazy_event.mappings.UIDone

local lazy_file_events = { "BufRead", "BufNewFile", "BufWritePre"}

local done_lazy_file = false

local function load_lazy_file()
  if done_lazy_file then return end
  done_lazy_file = true
  vim.api.nvim_exec_autocmds("User", { pattern = "LazyFile", modeline = false })
end

-- schedule wrap so that nested autocmds are executed
-- and the UI can continue rendering without blocking
load_lazy_file = vim.schedule_wrap(load_lazy_file)

vim.api.nvim_create_autocmd(lazy_file_events, {
  callback = function()
    load_lazy_file()
  end,
})

vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    vim.schedule(function()
      vim.api.nvim_exec_autocmds("User", { pattern = "UIDone", modeline = false })
    end)
  end,
})

