local frame = require "mcu.frame.framework"

local M = {}
M = frame

function M:get(var_map)
	--self.cmd["CALL"] = "CALLME"
	self.var = var_map
	return self
end


return M
