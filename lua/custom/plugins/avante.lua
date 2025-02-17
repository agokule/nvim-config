return {
  "yetone/avante.nvim",
  event = "BufRead",
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  enabled = vim.g.enable_ai,
  opts = {
    provider = "copilot",
  },
  build = (vim.loop.os_uname().sysname == "Windows_NT") and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
  dependencies = {
    "stevearc/dressing.nvim",
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
