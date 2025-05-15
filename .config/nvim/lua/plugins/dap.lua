return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {
				highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
				highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
				clear_on_continue = true, -- clear virtual text on "continue" (might cause flickering when stepping)
			},
		},
		"nvim-neotest/nvim-nio",
		"jonboh/nvim-dap-rr",
		"williamboman/mason.nvim",
	},
	config = function()
		local dap = require("dap")
		local ui = require("dapui")

		ui.setup()
		require("nvim-dap-virtual-text").setup()

		local cpptools_path = vim.fn.expand("$MASON/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7")
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = cpptools_path,
		}

		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

		vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
		-- vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

		vim.keymap.set("n", "<F1>", dap.terminate)
		vim.keymap.set("n", "<F2>", dap.restart)
		vim.keymap.set("n", "<F7>", dap.continue)
		vim.keymap.set("n", "<F8>", dap.step_over)
		vim.keymap.set("n", "<F9>", dap.step_into)
		vim.keymap.set("n", "<F10>", dap.step_out)
		vim.keymap.set("n", "<F11>", dap.pause)
		vim.keymap.set("n", "<F56>", dap.down) -- <A-F8>
		vim.keymap.set("n", "<F57>", dap.up) -- <A-F9>

		local rr_dap = require("nvim-dap-rr")
		rr_dap.setup({
			mappings = {
				-- you will probably want to change these defaults to that they match
				-- your usual debugger mappings
				continue = "<F7>",
				step_over = "<F8>",
				step_into = "<F9>",
				step_out = "<F10>",
				reverse_continue = "<F19>", -- <S-F7>
				reverse_step_over = "<F20>", -- <S-F8>
				reverse_step_into = "<F21>", -- <S-F9>
				reverse_step_out = "<F22>", -- <S-F10>
				-- instruction level stepping
				step_over_i = "<F32>", -- <C-F8>
				step_into_i = "<F33>", -- <C-F9>
				step_out_i = "<F34>", -- <C-F10>
				reverse_step_over_i = "<F44>", -- <SC-F8>
				reverse_step_into_i = "<F45>", -- <SC-F9>
				reverse_step_out_i = "<F46>", -- <SC-F10>
			},
		})
		dap.configurations.rust = { rr_dap.get_rust_config() }
		dap.configurations.cpp = { rr_dap.get_config() }

		ui.setup({
			layouts = {
				{
					elements = {
						"scopes",
						"breakpoints",
						"stacks",
						"watches",
					},
					size = 40,
					position = "left",
				},
				{
					elements = {
						"repl",
						"console",
					},
					size = 10,
					position = "bottom",
				},
			},
		})

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end
	end,
}
