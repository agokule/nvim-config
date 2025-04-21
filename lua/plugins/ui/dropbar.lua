---@return string? path
local function get_component_path_under_cursor()
  local menu = require('dropbar.utils').menu.get_current()
  if not menu then
    return
  end
  local component =
  menu:get_component_at(vim.api.nvim_win_get_cursor(0), true)
  if
    not component
    or not component.data.path
    or not vim.uv.fs_stat(component.data.path)
  then
    return
  end
  return component.data.path
end

return {
    'Bekaboo/dropbar.nvim',
    config = function()
      require('dropbar').setup({
        menu = {
          keymaps = {
            e = function ()
              local path = get_component_path_under_cursor()

              require('mini.files').open(path)
            end,
            D = function()
              local path = get_component_path_under_cursor()
              print('path: ' .. vim.inspect(path))
              if not path then
                return
              end

              local choice = vim.fn.confirm(
                string.format('Delete %s?', path),
                '&Yes\n&No\n&Cancel'
              )
              if choice > 1 then
                return
              end

              vim.fn.delete(path)
              -- Do something to redraw the menu
            end,
            a = function()
              local path = get_component_path_under_cursor()
              if not path then
                return
              end

              local dir = vim.fs.dirname(path)
              local target
              vim.ui.input(
                { prompt = 'File name: ', completion = 'file' },
                function(input)
                  target = input
                end
              )
              if not target then
                return
              end

              target = vim.fs.joinpath(dir, target)
              if vim.endswith(target, '/') then
                vim.fn.mkdir(target, 'p')
              else
                local fd_target = io.open(target, 'w')
                if not fd_target then
                  return false
                end
                fd_target:write()
                fd_target:close()
              end
              -- Do something to redraw the menu
            end,
          },
        },
      })
      local dropbar_api = require('dropbar.api')
      vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
    end,
    event = 'VeryLazy'
}
