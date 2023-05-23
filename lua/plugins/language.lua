return {
  {
     "nvim-treesitter/nvim-treesitter",
     config = function()
	require("nvim-treesitter.configs").setup({
          auto_install = true,
	  highlight = {enable = true}

	})
     end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.rust_analyzer.setup({})
      lspconfig.lua_ls.setup({})
      lspconfig.solargraph.setup({})
    end
  }
}
