local function setDefault(t, d)
  local mt = { __index = function() return d end }
  setmetatable(t, mt)
end

-- ---- Icons (identical to your old setup) ---------------------------------
local cmp_menu_icons = {
  Text        = " ",
  Method      = "󰆧 ",
  Function    = "󰊕",
  Constructor = "󰮄 ",
  Field       = "󰇽 ",
  Variable    = " ",
  Class       = "",
  Interface   = " ",
  Module      = "",
  Property    = "󰜢",
  Unit        = "󰑭 ",
  Value       = "󰎠 ",
  Enum        = " ",
  Keyword     = " ",
  Snippet     = " ",
  Color       = "󰏘 ",
  File        = "󰈙",
  Reference   = " ",
  Folder      = "󰉋 ",
  EnumMember  = " ",
  Constant    = "󰏿",
  Struct      = " ",
  Event       = "",
  Operator    = "󰆕",
  TypeParameter = "󰅲",
  Codeium     = " "
}
setDefault(cmp_menu_icons, " ")

local longest_menu_kind_type_len = 13   -- “TypeParameter”

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function ()
    -- Customization for Pmenu
    vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#282C34", fg = "NONE" })
    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { fg = "#C5CDD9", bg = "#22252A" })
    vim.cmd[[
" gray
highlight! BlinkCmpLabelDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! BlinkCmpLabelMatch guibg=NONE guifg=#569CD6
highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
" light blue
highlight! BlinkCmpKindVariable guibg=NONE guifg=#9CDCFE
highlight! link BlinkCmpKindInterface CmpItemKindVariable
highlight! link BlinkCmpKindText BlinkCmpKindVariable 
" pink
highlight! BlinkCmpKindFunction guibg=NONE guifg=#C586C0
highlight! link BlinkCmpKindMethod BlinkCmpKindFunction 
" front
highlight! BlinkCmpKindKeyword guibg=NONE guifg=#D4D4D4
highlight! link BlinkCmpKindProperty BlinkCmpKindKeyword
highlight! link BlinkCmpKindUnit BlinkCmpKindKeyword
]]
  end
})

-- ---- Blink configuration -----------------------------------------------
return {
  'saghen/blink.cmp',

  event = "LazyFile",

  dependencies = {
    -- Makes LSP completions colorful
    "xzbdmw/colorful-menu.nvim",
  },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'enter' },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'normal',
      kind_icons = cmp_menu_icons
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      documentation = {
        auto_show = false,
      },
      accept = {
        auto_brackets = {
          enabled = false
        }
      },
      menu = {
        draw = {
          -- We don't need label_description now because label and label_description are already
          -- combined together in label by colorful-menu.nvim.
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
        }
      }
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
