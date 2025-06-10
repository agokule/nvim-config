return {
    'ggml-org/llama.vim',
    init = function ()
	vim.api.nvim_set_hl(0, "llama_hl_hint", {fg = "#e57284", ctermfg=209})
	vim.api.nvim_set_hl(0, "llama_hl_info", {fg = "#00937b", ctermfg=119})
    end
}
