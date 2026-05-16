vim.keymap.set('n', '<leader>cp', function()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_file_name = vim.fn.fnamemodify(current_file, ':r')
  local current_file_ext = vim.fn.fnamemodify(current_file, ':e')

  if current_file_ext == 'cpp' then
    if vim.uv.fs_stat(current_file_name .. '.h') then
      vim.cmd('e ' .. current_file_name .. '.h')
    else
      vim.cmd('e ' .. current_file_name .. '.hpp')
    end
  elseif current_file_ext == 'h' or current_file_ext == 'hpp' then
    vim.cmd('e ' .. current_file_name .. '.cpp')
  else
    vim.print('Unsupported file extension: ' .. current_file_ext)
  end
end, { desc = "Switch between C/C++ header and source file", buf = 0 })

