-- Automatically load the .nvim.lua when I :cd
vim.api.nvim_create_autocmd('DirChanged', {
    pattern = { 'window', 'tabpage', 'global', 'auto' },
    callback = function ()
        local cwd = vim.fn.getcwd()

        if not vim.fn.filereadable(cwd .. '/' .. vim.g.exrc_file) then
            return
        end
        if type(vim.secure.read(vim.g.exrc_file)) ~= 'string' then
            return
        end

        vim.cmd.source(vim.g.exrc_file)
    end
})

-- [[ Highlight on yank ]]
-- See `:help vim.hl.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})


-- taken from https://github.com/LazyVim/LazyVim/discussions/2184#discussioncomment-7841499
vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "*" },
    callback = function()
        -- vim.opt.formatoptions = vim.opt.formatoptions - "o"
        if vim.bo["ft"] == "css" then
            vim.opt_local.formatoptions:remove("r") -- don't enter comment leader on Enter in css files
        end
        vim.opt.formatoptions = vim.opt.formatoptions + {
            o = false, -- Don't continue comments with o and O
        }
    end,
    desc = "Don't continue comments with o and O",
})

-- temporary fix for https://github.com/neovim/neovim/issues/8587
-- taken from https://github.com/neovim/neovim/issues/8587#issuecomment-3557794273
vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
    group = vim.api.nvim_create_augroup('fuck_shada_temp', { clear = true }),
    pattern = { '*' },
    callback = function()
        local status = 0
        for _, f in ipairs(vim.fn.globpath(vim.fn.stdpath('data') .. '/shada', '*tmp*', false, true)) do
            if vim.tbl_isempty(vim.fn.readfile(f)) then
                status = status + vim.fn.delete(f)
            end
        end

        if status ~= 0 then
            vim.notify('Could not delete empty temporary ShaDa files.', vim.log.levels.ERROR)
            vim.fn.getchar()
        end
    end,
    desc = "Delete empty temp ShaDa files"
})
