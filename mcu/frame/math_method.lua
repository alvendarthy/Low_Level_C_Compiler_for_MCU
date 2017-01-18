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
	return string.format("%s\n%s\n%s",
			normal_cmd("RTOA", arg2), 
			normal_cmd("RADDA", arg1, "A"), 
			normal_cmd("ATOR", tar))
end

function math_int8_int8_sub_int8(tar, arg1, arg2)
	 return string.format("%s\n%s\n%s",
                        normal_cmd("RTOA", arg2), 
                        normal_cmd("RSUBA", arg1, "A"), 
                        normal_cmd("ATOR", tar))
end

function math_int8_int8_add_imd(tar, arg1, arg2)
        return string.format("%s\n%s\n%s",
                        normal_cmd("ITOA", arg2),
                        normal_cmd("RADDA", arg1, "A"),
                        normal_cmd("ATOR", tar))
end

function math_int8_imd_add_int8(tar, arg1, arg2)
	return math_int8_int8_add_imd(tar, arg2, arg1)
end

function math_int8_int8_sub_imd(tar, arg1, arg2)
        return string.format("%s\n%s\n%s",
                        normal_cmd("ITOA", arg2),
                        normal_cmd("RSUBA", arg1, "A"),
                        normal_cmd("ATOR", tar))
end

function math_int8_imd_sub_int8(tar, arg1, arg2)
        return string.format("%s\n%s\n%s",
                        normal_cmd("RTOA", arg2),
                        normal_cmd("ISUBA", arg1, "A"),
                        normal_cmd("ATOR", tar))
end

function math_int8_eq_int8(tar, arg1, arg2)
	return string.format("%s\n%s",
                        normal_cmd("ITOA", arg1),
                        normal_cmd("ATOR", tar))
end


function math_int8_eq_imd(tar, arg1, arg2)

	if(arg1 == "0") then
		return normal_cmd("CLRR", tar)
	end

	return string.format("%s\n%s",
                        normal_cmd("RTOA", arg1),
                        normal_cmd("ATOR", tar))
end

function math_int8_incr(tar, arg1, arg2)
	return normal_cmd("RINCR", tar)
end

function math_int8_decr(tar, arg1, arg2)
	return normal_cmd("RDECR", tar)
end

local M = {
	["int8=int8+int8"] = math_int8_int8_add_int8,
	["int8=int8-int8"] = math_int8_int8_sub_int8,
	["int8=int8+imd"] = math_int8_int8_add_imd,
	["int8=imd+int8"] = math_int8_imd_add_int8,
	["int8=int8-imd"] = math_int8_int8_sub_imd,
	["int8=imd-int8"] = math_int8_imd_sub_int8,
	["int8=imd"] = math_int8_eq_imd,
	["int8=int8"] = math_int8_eq_int8,
	["int8++"] = math_int8_incr,
	["int8--"] = math_int8_decr
}

function T.get(map)
        cmd_map = map
        return M
end

return T
