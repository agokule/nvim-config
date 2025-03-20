local function setup_vendors()
  local vendors = {}

  -- Run the curl command to fetch the list of models
  local handle = io.popen('curl -s http://127.0.0.1:1234/v1/models')
  if not handle then
    vim.notify(string.format('Failed to execute curl command: %s', handle:read()))
    return
  end

  -- Read the response body
  local body = handle:read('*a')
  handle:close()

  if not body then
    vim.notify('Curl failed: ' .. body)
    return
  end

  -- Parse the JSON response
  local data = vim.json.decode(body)
  if not data then
    vim.notify('Failed to parse JSON response: ' .. body, vim.log.levels.ERROR)
    return
  end

  for _, model in ipairs(data.data) do
    vendors[model.id] = {
      __inherited_from = 'openai',
      api_key_name = '',
      endpoint = 'http://127.0.0.1:1234/v1',
      model = model.id,
    }
  end
  vim.print(vendors)
  return vendors
end

return {
  "yetone/avante.nvim",
  lazy = true,
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  enabled = vim.g.enable_ai,
  opts = function ()
    return {
      vendors = setup_vendors(),
    }
  end,
  cmd = {
    'AvanteAsk',
    'AvanteBuild',
    'AvanteChat',
    'AvanteEdit',
    'AvanteFocus',
    'AvanteRefresh',
    'AvanteSwitchProvider',
    'AvanteToggle',
    'AvanteShowRepoMap'
  },
  keys = {
    { '<leader>aa', function() require('avante.api').ask() end, desc = 'Ask Avante' },
    { '<leader>ae', function() require('avante.api').edit() end, desc = 'Edit code with Avante' },
    { '<leader>ac', function() require('avante.api').chat() end, desc = 'Chat with Avante' },
    { '<leader>af', function() require('avante.api').focus() end, desc = 'Switch sidebar focus avante' },
    { '<leader>ar', function() require('avante.api').refresh() end, desc = 'Refresh avante sidebar' },
    { '<leader>a?', function() require('avante.api').switch_provider() end, desc = 'Switch avante ai model' },
    { '<leader>as', function() require('avante.api').select_model() end, desc = 'Select avante ai model' },
    { '<leader>at', function() require('avante.api').toggle() end, desc = 'Toggle avante sidebar visibility' },
  },
  build = (vim.loop.os_uname().sysname == "Windows_NT") and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    { "zbirenbaum/copilot.lua", main = "copilot", opt = {}, cmd = "Copilot" }, -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
