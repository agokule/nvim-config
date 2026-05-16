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

vim.keymap.set('n', '<leader>fc', function() vim.cmd.edit(vim.g.exrc_file) end, { desc = "Edit the EXRC file" })

vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { desc = 'Escape terminal mode' })

vim.keymap.set('i', '<C-BS>', '<C-W>', { desc = 'Delete the previous word in insert mode' })
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

