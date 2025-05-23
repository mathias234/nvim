return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = { enable = true }

      })
    end
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-lint",
      "mhartington/formatter.nvim",
      'Decodetalkers/csharpls-extended-lsp.nvim',
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      require("formatter").setup()
      local lspconfig = require('lspconfig')

      lspconfig.lua_ls.setup({})
      lspconfig.ruby_lsp.setup({})
      lspconfig.rust_analyzer.setup({})


      lspconfig.csharp_ls.setup({
        handlers = {
          ["textDocument/definition"] = require('csharpls_extended').handler,
          ["textDocument/typeDefinition"] = require('csharpls_extended').handler,
        },
        -- rest of your settings
      })


      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     'simrat39/inlay-hints.nvim',
  --     --'Decodetalkers/csharpls-extended-lsp.nvim',
  --     'lukas-reineke/lsp-format.nvim',
  --   },
  -- config = function()
  --   require('lsp-format').setup()
  --   require("inlay-hints").setup()
  --   local lspconfig = require('lspconfig')
  --   lspconfig.rust_analyzer.setup({
  --     settings = {
  --       ['rust-analyzer'] = {
  --         diagnostics = {
  --           enable = true;
  --         },
  --       }
  --     }
  --   })
  --   lspconfig.lua_ls.setup({})
  --   --lspconfig.solargraph.setup({
  --   --})

  --   lspconfig.ruby_lsp.setup({})
  --   lspconfig.ts_ls.setup({})
  --   lspconfig.volar.setup({
  --     init_options = {
  --         typescript = {
  --             tsdk = "/home/mathias/.asdf/installs/nodejs/18.16.0/lib/node_modules/typescript/lib"
  --         }
  --     }
  --   })

  --   lspconfig.csharp_ls.setup({
  --     handlers = {
  --       ["textDocument/definition"] = require('csharpls_extended').handler,
  --       ["textDocument/typeDefinition"] = require('csharpls_extended').handler,
  --     },
  --     -- rest of your settings
  --   })

  --   -- C++
  --   lspconfig.clangd.setup({
  --     on_attach = require("lsp-format").on_attach,
  --   })



  --}
}
