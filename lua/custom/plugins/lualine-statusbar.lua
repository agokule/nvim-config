local uv = require("luv")

local current_time = ""
local function set_interval(interval, callback)
    local timer = uv.new_timer()
    local function ontimeout()
        callback(timer)
    end
    uv.timer_start(timer, interval, interval, ontimeout)
    return timer
end

local function update_wakatime()
    local stdin = uv.new_pipe()
    local stdout = uv.new_pipe()
    local stderr = uv.new_pipe()

    local handle, pid =
        uv.spawn(
        "wakatime-cli",
        {
            args = {"--today"},
            stdio = {stdin, stdout, stderr}
        },
        function(code, signal) -- on exit
            stdin:close()
            stdout:close()
            stderr:close()
        end
    )

    uv.read_start(
        stdout,
        function(err, data)
            assert(not err, err)
            if data then
                current_time = " " .. data:sub(1, #data - 2) .. " "
            end
        end
    )
end

set_interval(5000, update_wakatime)

local function get_wakatime()
    return current_time
end

return {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
        options = {
            icons_enabled = true,
            theme = 'onedark',
            component_separators = '',
            section_separators = '',
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = {
                'encoding',
                'fileformat',
                'filetype'
            },
            lualine_y = { 'progress', get_wakatime },
            lualine_z = { 'location' }
        }
    }
}
