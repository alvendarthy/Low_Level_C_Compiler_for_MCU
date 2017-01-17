local T = {}
local cmd_map = {}

function normal_cmd(cmd, arg1, arg2)
        cmd = cmd_map[cmd] or cmd
        if(nil == arg1) then
                return string.format("\t%-16s %-16s %-16s", cmd, "","")
        elseif(nil == arg2)then
                return string.format("\t%-16s %-16s %-16s", cmd, arg1,"")
        else
                return string.format("\t%-16s %-16s %-16s", cmd, arg1 .. ",",arg2)
        end
end


function math_int8_int8_add_int8(tar, arg1, arg2)
	return string.format("%s\n%s\n%s",normal_cmd("RTOA", arg2), normal_cmd("RADDA", arg1, A), normal_cmd("ATOR", tar))
end

local M = {
	["int8=int8+int8"] = math_int8_int8_add_int8
}

function T.get(map)
        cmd_map = map
        return M
end

return T
