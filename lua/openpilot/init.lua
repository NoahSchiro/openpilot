local cmp = require('cmp')
local api = require('openpilot.api')

local source = {}

source._make_api_call = function(self, input, callback)

	local data = {
		model = 'mistral',
		prompt = input,
		stream = false
	}

	api:get(data, callback)
end

source.new = function()
	return setmetatable({}, { __index = source})
end

-- For now, the source is always available
source.is_available = function()
	return true
end

-- Return the last k lines from current cursor position 
source._get_last_k_lines = function(k)

	-- Line the cursor is on
	local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
	
	-- Line we want to go back to (if k is nil then just zero
	local start_line = 0
	if k then
		start_line = math.max(0, cursor_line - (k+1))
	end

	print(start_line)

	local last_lines = vim.api.nvim_buf_get_lines(0, start_line, cursor_line-1, false)

	local last_lines_text = table.concat(last_lines, '\n')

	-- Return those lines
	return last_lines_text
end

source.complete = function(self, request, callback)
	
	local buffer_content = source._get_last_k_lines()
	local last_k_lines = source._get_last_k_lines(10)

	-- Handling the API call asynchronously
	self:_make_api_call(buffer_content, function(response)
		-- Construct completions after receiving the response
		local completions = {
			{
				word = response, -- Assuming 'response' is the actual text you want to insert
				label = 'OpenPilot Code',
				kind = cmp.lsp.CompletionItemKind.Snippet
			},
			{
				word = 'placeholder',
				label = 'OpenPilot Docs',
				kind = cmp.lsp.CompletionItemKind.Snippet
			},
		}

		-- Call the callback with the completions after the response is processed
		callback({ items = completions })
	end)
end

source.get_metadata = function()
	return {
		priority = 100, -- Set the priority of this source
		menu = '[OpenPilot]', -- Text to show in the completion menu
		dup = 0, --Whether to allow duplicate items (no)
	}
end

return source
