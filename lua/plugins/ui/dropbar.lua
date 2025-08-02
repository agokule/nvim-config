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
          },
        },
      })
      local dropbar_api = require('dropbar.api')
      vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
    end,
    event = 'UIDone'
}
