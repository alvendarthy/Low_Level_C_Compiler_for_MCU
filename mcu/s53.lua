local frame = require "mcu.frame.framework"
local cmd_map = require "mcu.frame.cmd_map"
local cmp_method = require "mcu.frame.cmp_method"

local M = {}
M = frame

function M:get(var_map)
	--self.cmd["CALL"] = "CALLME"
	self.var = var_map
	self.cmd_map = cmd_map
	self.cmp_method = cmp_method.get(cmd_map)
	return self
end


return M
