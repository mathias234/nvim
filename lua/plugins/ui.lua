return {

  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() 
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("nvim-tree").setup({})
      local api = require("nvim-tree.api")
      vim.keymap.set('n', '<leader>t', api.tree.toggle, {})
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/vim-vsnip" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
	snippet = {
	  expand = function(args)
	    vim.fn["vsnip#anonymous"](args.body)
	  end
	},
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),

        sources = cmp.config.sources({ {name = "copilot", group_index = 2}, { name = "nvim_lsp", group_index = 2 }, { name = "vsnip", group_index = 2 } })
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {'zbirenbaum/copilot.lua'},
    config = function ()
      require("copilot").setup({
        suggestion = { enabled = false },
	panel = { enabled = false }
      })
      require("copilot_cmp").setup()
    end
  },
  {
    "romgrk/barbar.nvim",
    dependencies = {
	'lewis6991/gitsigns.nvim',
	'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {}
  },
  {
    'nmac427/guess-indent.nvim',
    config = function ()
      require('guess-indent').setup({})
    end
  }
}
