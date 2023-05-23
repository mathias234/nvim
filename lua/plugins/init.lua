return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000,
    init = function()
      vim.o.background = "dark"
      vim.cmd([[colorscheme catppuccin]])
    end
  },
}
