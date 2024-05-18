require("neodev").setup({
   library = {
       enabled = true,
       plugins = {"nvim-treesitter", "lspconfig" },
       runtime = true,
       types = true,
   },
   lspconfig = true,
   override = function(root_dir, library)
       library.enabled = true
       library.plugins = true
   end,
   pathStrict = true,
})

lspconfig.lua_ls.setup({})
