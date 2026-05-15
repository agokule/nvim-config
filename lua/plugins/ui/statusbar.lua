local uv = require("luv")

-- ─── WakaTime ────────────────────────────────────────────────────────────────

local current_time = ""

local function set_interval(interval, callback)
    local timer = uv.new_timer()
    uv.timer_start(timer, interval, interval, function() callback(timer) end)
    return timer
end

local function update_wakatime()
    local stdin  = uv.new_pipe()
    local stdout = uv.new_pipe()
    local stderr = uv.new_pipe()

    uv.spawn(
        "wakatime-cli",
        { args = { "--today" }, stdio = { stdin, stdout, stderr } },
        function()
            stdin:close()
            stdout:close()
            stderr:close()
        end
    )

    uv.read_start(stdout, function(err, data)
        assert(not err, err)
        if data then
            current_time = " " .. data:sub(1, #data - 2)
        end
    end)
end

set_interval(60000, update_wakatime)

local function get_wakatime()
    return " " .. current_time
end

-- ─── Word / reading / speaking count ─────────────────────────────────────────

local function is_markdown()
    return vim.bo.filetype == "markdown" or vim.bo.filetype == "asciidoc"
end

local function wordcount()
    local mode = vim.fn.mode()
    if mode == "v" or mode == "V" or mode == "\22" then
        return vim.fn.wordcount().visual_words or 0
    end
    return vim.fn.wordcount().words
end

local function section_writing()
    if not is_markdown() then return "" end
    local wc = tostring(wordcount())
    local rt = tostring(math.ceil(wordcount() / 170.0))
    local st = tostring(math.ceil(wordcount() / 100.0))
    return " " .. wc .. " words   " .. rt .. " min  " .. st .. " min"
end

-- ─── Custom sections to match lualine visual output ──────────────────────────

-- 1. MODE — uppercase to match lualine's "NORMAL" / "INSERT" etc.
--    Reuses mini's highlight groups so the green/blue/etc. colors are preserved.
local function section_mode_custom()
    local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
    return mode:upper(), mode_hl
end

-- 2. FILENAME — basename only (lualine path=0 default).
--    Appends [+] for modified and [-] for readonly, matching lualine's symbols.
local function section_filename_custom()
    local fname = vim.fn.expand("%:t")
    if fname == "" then fname = "[No Name]" end
    if vim.bo.modified then fname = fname .. " [+]" end
    if not vim.bo.modifiable or vim.bo.readonly then fname = fname .. " [-]" end
    return fname
end

-- 3. FILEINFO — replicates lualine_x left-to-right order:
--      encoding  |  fileformat icon  |  filetype icon + name
--    mini.statusline's built-in section_fileinfo shows them in a different
--    order and also appends file size, so we build this from scratch.
local function section_fileinfo_custom()
    if vim.bo.buftype ~= "" then return "" end   -- skip terminal, quickfix, etc.

    local parts = {}

    -- Encoding (lualine 'encoding' component)
    local enc = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
    if enc ~= "" then table.insert(parts, enc) end

    -- Fileformat icon (lualine 'fileformat' component with Nerd Font symbols)
    local fmt_icons = { unix = "", dos = "", mac = "" }
    table.insert(parts, fmt_icons[vim.bo.fileformat] or vim.bo.fileformat)

    -- Filetype with icon (lualine 'filetype' component, colored=true)
    local ft = vim.bo.filetype
    if ft ~= "" then
        local icon = ""
        local ok, devicons = pcall(require, "nvim-web-devicons")
        if ok then
            local ic = devicons.get_icon_by_filetype(ft, { default = false })
            if ic then icon = ic .. " " end
        end
        table.insert(parts, icon .. ft)
    end

    return table.concat(parts, "  ")
end

-- 4. PROGRESS — standalone scroll percentage, matching lualine's 'progress'
local function section_progress()
    local cur  = vim.fn.line(".")
    local last = vim.fn.line("$")
    if last == 0 then return "0%" end
    return string.format("%d%%%%", math.floor(cur / last * 100))
end

-- 5. LOCATION — "line:col" only, matching lualine's 'location' component.
--    mini's built-in shows "line|total│col|total" which is far more verbose.
local function section_location_custom()
    return string.format("%d:%d", vim.fn.line("."), vim.fn.col("."))
end

-- ─── Active statusline ────────────────────────────────────────────────────────

local function active_content()
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal', { update = true, bg = '#98c379' })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsert', { update = true, bg = '#61afef' })

    local mode, mode_hl = section_mode_custom()
    local git            = MiniStatusline.section_git({ trunc_width = 40 })
    local diff           = MiniStatusline.section_diff({ trunc_width = 75 })
    local diagnostics    = MiniStatusline.section_diagnostics({
        trunc_width = 75,
        signs = {

        }
    })
    local filename       = section_filename_custom()
    local writing        = section_writing()
    local fileinfo       = section_fileinfo_custom()
    local progress       = section_progress()
    local wakatime       = get_wakatime()
    local location       = section_location_custom()

    return MiniStatusline.combine_groups({
        { hl = mode_hl,                  strings = { mode } },
        { hl = "MiniStatuslineDevinfo",  strings = { git, diff, diagnostics } },
        "%<",   -- truncation point
        { hl = "MiniStatuslineFilename", strings = { filename, writing } },
        "%=",   -- right-align the rest
        { hl = "MiniStatuslineFilename", strings = { fileinfo } },
        { hl = "MiniStatuslineFileinfo", strings = { progress, wakatime } },
        { hl = mode_hl,                  strings = { location } },
    })
end

-- ─── Inactive statusline ─────────────────────────────────────────────────────
-- Mirrors lualine's inactive_sections: just the filename, no other info.

local function inactive_content()
    return MiniStatusline.combine_groups({
        { hl = "MiniStatuslineInactive", strings = { section_filename_custom() } },
    })
end

-- ─── CompetiTest buffer-local override ───────────────────────────────────────

vim.api.nvim_create_autocmd("FileType", {
    pattern = "CompetiTest",
    callback = function()
        vim.b.ministatusline_config = {
            content = {
                active = function()
                    local title  = vim.b.competitest_title or "CompetiTest"
                    local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
                    return MiniStatusline.combine_groups({
                        { hl = "MiniStatuslineModeNormal", strings = { "⬆️  " .. title .. "  ⬆️" } },
                        "%=",
                        { hl = "MiniStatuslineFileinfo",  strings = { search, section_location_custom() } },
                    })
                end,
                inactive = function()
                    local title = vim.b.competitest_title or "CompetiTest"
                    return MiniStatusline.combine_groups({
                        { hl = "MiniStatuslineInactive", strings = { "⬆️ " .. title .. " ⬆️" } },
                    })
                end,
            },
        }
    end,
})

-- ─── Lazy plugin spec ─────────────────────────────────────────────────────────

---@type LazySpec
return {
    "echasnovski/mini.statusline",
    version = "*",
    opts = {
        content = {
            active   = active_content,
            inactive = inactive_content,
        },
        use_icons = true,
    }
}
