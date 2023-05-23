return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-telescope/telescope-dap.nvim",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    local dap = require("dap")
    dap.adapters.lldb = {
      type = "executable",
      command = "/usr/bin/lldb-vscode",
      name = "lldb",
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

	dap.adapters.rdbg = function(callback, config)
	  callback {
	    type = "server",
	    host = "127.0.0.1",
	    port = "${port}",
	    executable = {
	      command = "rdbg",
	      args = { "-n", "--open", "--port", "${port}",
		"-c", "--", "bundle", "exec", config.command, config.script,
	      },
	    },
	  }
	end

    dap.configurations.ruby = {
      {
        type = "rdbg",
        name = "rails",
        request = "launch",
	cwd = "${workspaceFolder}",
        command = "${workspaceFolder}/bin/rails",
        script = "server",
      },
      {
        type = "rdbg",
        name = "rspec file",
        request = "launch",
	cwd = "${workspaceFolder}",
        command = "rspec",
        script = "${file}",
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
    vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
    vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
    vim.keymap.set('n', '<Leader>du', function() require('dapui').toggle() end)
  end,
}
