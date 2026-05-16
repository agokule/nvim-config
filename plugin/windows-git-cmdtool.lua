if not (vim.fn.has('win32')) then
    return
end

local git = vim.fn.exepath("git")
if #git == 0 then
    vim.notify("Git is required for this on Windows platform")
end
local git_cmdtool_path = vim.fs.joinpath(vim.fs.dirname(vim.fs.dirname(git)), "usr/bin")
vim.env.PATH = vim.env.PATH .. ';' .. git_cmdtool_path

