return {
    "catgoose/nvim-colorizer.lua",
    cmd = 'ColorizerToggle',
    main = "colorizer",
    opts = {
        filetypes = { "*" },
        user_default_options = {
            names = true,                 -- "Name" codes like Blue or red.  Added from `vim.api.nvim_get_color_map()`
            names_opts = {                -- options for mutating/filtering names.
                lowercase = true,         -- name:lower(), highlight `blue` and `red`
                camelcase = true,         -- name, highlight `Blue` and `Red`
                uppercase = false,        -- name:upper(), highlight `BLUE` and `RED`
                strip_digits = false,     -- ignore names with digits,
                -- highlight `blue` and `red`, but not `blue3` and `red4`
            },
            -- Expects a table of color name to #RRGGBB value pairs.  # is optional
            -- Example: { cool = "#107dac", ["notcool"] = "ee9240" }
            -- Set to false|nil to disable, for example when setting filetype options
            names_custom = false,                               -- Custom names to be highlighted: table|function|false|nil
            RGB = true,                                         -- #RGB hex codes
            RGBA = true,                                        -- #RGBA hex codes
            RRGGBB = true,                                      -- #RRGGBB hex codes
            RRGGBBAA = false,                                   -- #RRGGBBAA hex codes
            AARRGGBB = false,                                   -- 0xAARRGGBB hex codes
            rgb_fn = false,                                     -- CSS rgb() and rgba() functions
            hsl_fn = false,                                     -- CSS hsl() and hsla() functions
            css = false,                                        -- Enable all CSS *features*:
            -- names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn
            css_fn = false,                                     -- Enable all CSS *functions*: rgb_fn, hsl_fn
            -- Highlighting mode.  'background'|'foreground'|'virtualtext'
            mode = "virtualtext",                               -- Set the display mode
            -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True is same as normal
            tailwind = false,                                   -- Enable tailwind colors
            -- parsers can contain values used in |user_default_options|
            sass = { enable = false, parsers = { "css" } },     -- Enable sass colors
            -- Virtualtext character to use
            virtualtext = "██",
            -- Display virtualtext inline with color
            virtualtext_inline = true,
            -- Virtualtext highlight mode: 'background'|'foreground'
            virtualtext_mode = "foreground",
            -- update color values even if buffer is not focused
            -- example use: cmp_menu, cmp_docs
            always_update = false,
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
        -- Boolean | List of usercommands to enable
        user_commands = true,     -- Enable all or some usercommands
    }
}
