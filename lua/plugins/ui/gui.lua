return {
    'equalsraf/neovim-gui-shim',
    cond = (vim.fn.has('gui_running') and not vim.g.neovide)
}
