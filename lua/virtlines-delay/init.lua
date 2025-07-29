local M = {}

local const_plugin = "virtlines-delay"
local config = require(const_plugin .. ".config")
local const_augroup = "vl_delay"
local t = vim.uv.new_timer()
local lastline = -1

local function start_timer()
	if t ~= nil then
		t:stop()
		t:start(
			config.delay,
			0,
			vim.schedule_wrap(function()
				vim.diagnostic.config({ virtual_lines = { current_line = true } })
			end)
		)
	end
end

function M.setup(opts)
	config = vim.tbl_deep_extend("keep", opts, config)
	local group = vim.api.nvim_create_augroup(const_augroup, { clear = true })
	vim.api.nvim_create_autocmd("CursorMoved", {
		group = const_augroup,
		callback = function()
			local currentline = vim.fn.getcurpos(0)[2]
			if currentline ~= lastline then
				lastline = currentline
				start_timer()
				vim.diagnostic.config({ virtual_lines = false })
			end
		end,
	})
end

return M
