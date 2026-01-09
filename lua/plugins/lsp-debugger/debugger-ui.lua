return {
    "MironPascalCaseFan/debugmaster.nvim",
    -- osv is needed if you want to debug neovim lua code. Also can be used 
    -- as a way to quickly test-drive the plugin without configuring debug adapters 
    dependencies = { "mfussenegger/nvim-dap", "jbyuki/one-small-step-for-vimkind", },
    config = function()
        local dm = require("debugmaster")
        dm.plugins.osv_integration.enabled = true -- needed if you want to debug neovim lua code
    end,
    keys = {
        { "<leader>m", function() vim.cmd.Hardtime('toggle') require("debugmaster").mode.toggle() end, mode = { 'n', 'v' }, nowait = true } 
    }
}
