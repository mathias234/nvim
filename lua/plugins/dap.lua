return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-telescope/telescope-dap.nvim",
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "suketa/nvim-dap-ruby"
  },
  config = function()
    local dap = require("dap")
    require('dap-ruby').setup()
    dap.adapters.lldb = {
      type = "executable",
      command = "/usr/bin/lldb-vscode",
      name = "lldb",
    }
    dap.adapters.coreclr = {
      type = 'executable',
      command = '/usr/bin/netcoredbg',
      args = { '--interpreter=vscode' }
    }

    dap.configurations.rust = {
      {
        type = "lldb",
        request = "launch",
        name = "Debug",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
      },
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
        cwd = function()
          local program_path = vim.fn.input('Path to out', vim.fn.getcwd() .. '/bin/Debug/', 'file')
          return vim.fn.fnamemodify(program_path, ":h") -- Returns the directory of the selected program
        end,
      },
    }

    require("telescope").load_extension("dap")
    require("dapui").setup()
    local dapui = require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
    vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
    vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
    vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
    vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
    vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
    vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
    vim.keymap.set('n', '<Leader>lp',
      function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
    vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
    vim.keymap.set('n', '<Leader>du', function() require('dapui').toggle() end)
  end,
}
