local M = {}

local const_plugin_name = "virtlines-delay"
local config = require(const_plugin_name .. ".config")

local const_augroup = "v_delay"

local t = vim.uv.new_timer()

local last_line = -1
local original_config
local disabled = false

local function disable_v()
	if disabled == false then
		disabled = true
		-- save format and original setting for later
		original_config = vim.diagnostic.config()
		vim.diagnostic.config({ virtual_lines = false })
		vim.diagnostic.config({ virtual_text = true })
	end
end

local function enable_v()
	if disabled then
		disabled = false
		-- merge original virtual_lines settings with current config
		--vim.notify(vim.inspect(original_config))
		local new_conf = vim.tbl_deep_extend("keep", original_config, { virtual_lines = { current_line = true } })
		vim.diagnostic.config({ virtual_text = new_conf.virtual_text, virtual_lines = new_conf.virtual_lines })
	end
end

local function start_timer()
	if (t ~= nil) and (t:is_active() == false) then
		t:start(
			config.delay,
			0,
			vim.schedule_wrap(function()
				enable_v()
			end)
		)
	end
end

local function check_moved()
	local currentline = vim.fn.getcurpos(0)[2]
	if currentline ~= last_line then
		last_line = currentline
		disable_v()
		if t ~= nil then
			t:stop()
		end
	else
		start_timer()
	end
end

function M.setup(opts)
	-- ensure virtual_lines are enabled
	-- but don't mess it up if format is set
	local current_config = vim.diagnostic.config() or {}
	if current_config.virtual_lines == nil then
		current_config.virtual_lines = false
	end
	if current_config.virtual_lines == false then
		vim.diagnostic.config({ virtual_lines = true })
	end

	config = vim.tbl_deep_extend("keep", opts, config)
	local augroup = vim.api.nvim_create_augroup(const_augroup, { clear = true })
	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorHold" }, {
		group = augroup,
		callback = check_moved,
	})
end

return M
