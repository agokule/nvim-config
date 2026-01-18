return {
   "m4xshen/hardtime.nvim",
   lazy = false,
   dependencies = { "MunifTanjim/nui.nvim" },
   opts = {
      disable_mouse = false,
      disabled_filetypes = {
         ["dropbar_menu"] = true,
         ["CompetiTest"] = true,
         ["gitsigns-blame"] = true,
      }
   },
}
