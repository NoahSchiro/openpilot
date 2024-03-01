local job = require('plenary.job')

api = {}

local function json_decode(data)
  local status, result = pcall(vim.fn.json_decode, data)
  if status then
    return result
  else
    return nil, result
  end
end

function api:get(data, callback)

	-- URL for the ollama server
	local url = 'http://127.0.0.1:11434/api/generate'

	local encoded_data = vim.fn.json_encode(data)

	local args = { url, '-d ' .. encoded_data }

	job
	:new({
		command = 'curl',
		args = args,
		on_exit = vim.schedule_wrap(function(response, exit_code)
			if exit_code ~= 0 then
				vim.notify('An Error Occurred ...', vim.log.levels.ERROR)
				callback({ { error = 'ERROR: API Error' } })
			end

			local result = table.concat(response:result(), '\n')
			local json = json_decode(result)
			if json == nil then
				callback({ { error = 'No Response.' } })
			else
				callback(json)
			end
		end),
	}):start()
end

return api
