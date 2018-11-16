local frame = require "mcu.frame.framework"
local cmd_map = require "mcu.s53.cmd_map"
local cmp_method = require "mcu.frame.cmp_method"
local math_method = require "mcu.frame.math_method"

local M = {}
M = frame

function normal_cmd(cmd_orig, arg1, arg2)
        cmd = cmd_map[cmd_orig] or cmd_orig

        if(type(cmd) == "function")then
                cmd, arg1, arg2 = cmd(cmd_orig, arg1, arg2)
        end

        if(nil == arg1) then
                return string.format("\t%-16s %-16s %-16s", cmd, "","")
        elseif(nil == arg2)then
                return string.format("\t%-16s %-16s %-16s", cmd, arg1,"")
        else
                return string.format("\t%-16s %-16s %-16s", cmd, arg1 .. ",",arg2)
        end
end


function math_int8_eq_imd(tar, arg1, arg2)
	if(arg1 == "0" and tar ~= "OPTION" and tar ~= "IOST")then
		return normal_cmd("CLRR", tar)
	end

        return string.format("%s\n%s",
                        normal_cmd("ITOA", arg1),
                        normal_cmd("ATOR", tar))
end

function M:get(var_map)
	--self.cmd["CALL"] = "CALLME"
	self.var = var_map
	self.cmd_map = cmd_map
	self.cmp_method = cmp_method.get(cmd_map)
	self.math_method = math_method.get(cmd_map)
	self.math_method["int8=imd"] = math_int8_eq_imd
	return self
end


return M
