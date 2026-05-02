---@type LazySpec
return {
    -- Highlight, edit, and navigate code
    'romus204/tree-sitter-manager.nvim',
    event = "LazyFile",
    cmd = 'TSManager',
    opts = {
        ensure_installed = {
            'lua', 'python', 'tsx', 'javascript', 'typescript', 'vimdoc',
            'vim', 'bash', 'html', 'css', 'cpp', 'c'
        }
    },
}
