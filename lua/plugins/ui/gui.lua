return {
    'equalsraf/neovim-gui-shim',
    enabled = (vim.fn.has('gui_running') and not vim.g.neovide)
}
