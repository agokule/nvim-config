return {
    'ggml-org/llama.vim',
    init = function ()
	vim.api.nvim_set_hl(0, "llama_hl_hint", {fg = "#e57284", ctermfg=209})
	vim.api.nvim_set_hl(0, "llama_hl_info", {fg = "#00937b", ctermfg=119})

	vim.g.llama_config = {
	    auto_fim = false,
	}

	vim.keymap.set('n', '<leader>ucl', ':LlamaToggle<cr>', { desc = 'Toggle Llama.cpp AI Auto Complete' })
	vim.keymap.set('n', '<leader>ucm', function ()
	    vim.g.llama_config.auto_fim = not vim.g.llama_config.auto_fim
	end, { desc = 'Toggle Llama.cpp AI Auto Complete Manual Mode' })

	vim.keymap.set('n', '<leader>ucc', function ()
	    vim.ui.select({ "qwen-1.5b", "qwen-3b", "qwen-7b" }, { prompt = "Llama.cpp AI Auto Complete" }, function (choice)
		vim.fn.setreg('+', "llama-server --fim-" .. choice .. "-default")
	    end)
	end, { desc = 'Copy Llama.cpp AI Auto Complete cmd to clipboard' })
    end
}
