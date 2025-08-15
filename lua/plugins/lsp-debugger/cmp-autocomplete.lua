-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local function setDefault(t, d)
    local mt = { __index = function() return d end }
    setmetatable(t, mt)
end
local cmp_menu_icons = {
  Text = " ",
  Method = "󰆧 ",
  Function = "󰊕",
  Constructor = "󰮄 ",
  Field = "󰇽 ",
  Variable = " ",
  Class = "",
  Interface = " ",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭 ",
  Value = "󰎠 ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = "󰏘 ",
  File = "󰈙",
  Reference = " ",
  Folder = "󰉋 ",
  EnumMember = " ",
  Constant = "󰏿",
  Struct = " ",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰅲",
  Codeium = " "
}
setDefault(cmp_menu_icons, " ")

local longest_menu_kind_type_len = 13 -- It is TypeParameter

return {
    'hrsh7th/nvim-cmp',
    cond = false,
    dependencies = {
        -- Adds LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',

        -- Makes LSP completions colorful
        "xzbdmw/colorful-menu.nvim",
    },
    event = "LazyFile",
    config = function()
        local cmp = require 'cmp'

        cmp.setup {
            mapping = cmp.mapping.preset.insert {
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete {},
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'codeium' },
            },
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, vim_item)
                    vim_item.menu = "   " ..
                        vim_item.kind .. string.rep(" ", longest_menu_kind_type_len - vim_item.kind:len()) .. ({
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            codeium = "[Codeium]",
                        })[entry.source.name]
                    vim_item.kind = cmp_menu_icons[vim_item.kind]


                    local highlights_info = require("colorful-menu").cmp_highlights(entry)
                    -- highlight_info is nil means we are missing the ts parser, it's
                    -- better to fallback to use default `vim_item.abbr`. What this plugin
                    -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
                    if highlights_info ~= nil then
                        vim_item.abbr_hl_group = highlights_info.highlights
                        vim_item.abbr = highlights_info.text
                    end

                    return vim_item
                end
            },
            matching = {
                disallow_fuzzy_matching = false,
                disallow_fullfuzzy_matching = false,
            },
            window = {
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            }
        }


        -- Customization for Pmenu
        vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
        vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

        vim.cmd [[
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! link CmpItemKindInterface CmpItemKindVariable
highlight! link CmpItemKindText CmpItemKindVariable
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! link CmpItemKindMethod CmpItemKindFunction
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! link CmpItemKindProperty CmpItemKindKeyword
highlight! link CmpItemKindUnit CmpItemKindKeyword
]]
    end
}
