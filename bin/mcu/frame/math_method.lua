local T = {}
local cmd_map = {}

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
                        normal_cmd("RTOA", arg1),
                        normal_cmd("ATOR", tar))
end


function math_int8_eq_imd(tar, arg1, arg2)

	if(arg1 == "0") then
		return normal_cmd("CLRR", tar)
	end

	return string.format("%s\n%s",
                        normal_cmd("ITOA", arg1),
                        normal_cmd("ATOR", tar))
end

function math_int8_add_eq_int8(tar, arg1, arg2)
	return string.format("%s\n%s",
                        normal_cmd("RTOA", arg1),
                        normal_cmd("RADDA", tar, "R"))
end


function math_int8_add_eq_imd(tar, arg1, arg2)
	if(arg1 == "0") then
                return nil
        end

	if(arg1 == "1") then
		return math_int8_incr(tar, arg1, arg2)
	end

	return string.format("%s\n%s",
                        normal_cmd("ITOA", arg1),
                        normal_cmd("RADDA", tar, "R"))
end

function math_int8_sub_eq_int8(tar, arg1, arg2)
	return string.format("%s\n%s",
                        normal_cmd("RTOA", arg1),
                        normal_cmd("RADDA", tar, "R"))
end


function math_int8_sub_eq_imd(tar, arg1, arg2)
	if(arg1 == "0") then
                return nil
        end

	if(arg1 == "1") then
		return math_int8_decr(tar, arg1, arg2)
	end

	return string.format("%s\n%s",
                        normal_cmd("ITOA", arg1),
                        normal_cmd("RADDA", tar, "R"))
end


function math_int8_incr(tar, arg1, arg2)
	return normal_cmd("RINCR", tar, "R")
end

function math_int8_decr(tar, arg1, arg2)
	return normal_cmd("RDECR", tar, "R")
end

function math_bit_eq_imd(tar, arg1, arg2)
	if(arg1 == "0") then
		return normal_cmd("BCLRR", tar)
	end

	return normal_cmd("BSTR", tar)
end

function math_int8_rr_imd(tar, arg1, arg2)
	local rn = tonumber(arg2) or 0
	local line = ""

	if(0 == rn) then
		return "OK"
	end

	if(arg1 == tar) then
		line =  normal_cmd("RRR", arg1, "R")

	else
		line =  normal_cmd("RRR", arg1, "A")
		line = line .. "\n" .. normal_cmd("ATOR", tar)
	end

	for i = 2, rn do
		line = line  .. "\n" .. normal_cmd("RRR", tar, "R")
	end

	return line
end

function math_int8_rrc_imd(tar, arg1, arg2)
	local rn = tonumber(arg2) or 0
	local line = ""

	if(0 == rn) then
		return "OK"
	end

	if(arg1 == tar) then
		line =  normal_cmd("RRRC", arg1, "R")

	else
		line =  normal_cmd("RRRC", arg1, "A")
		line = line .. "\n" .. normal_cmd("ATOR", tar)
	end

	for i = 2, rn do
		line = line  .. "\n" .. normal_cmd("RRRC", tar, "R")
	end

	return line
end

function math_int8_rl_imd(tar, arg1, arg2)
	local rn = tonumber(arg2) or 0
	local line = ""

	if(0 == rn) then
		return "OK"
	end

	if(arg1 == tar) then
		line =  normal_cmd("RRL", arg1, "R")

	else
		line =  normal_cmd("RRL", arg1, "A")
		line = line .. "\n" .. normal_cmd("ATOR", tar)
	end

	for i = 2, rn do
		line = line  .. "\n" .. normal_cmd("RRL", tar, "R")
	end

	return line
end

function math_int8_rlc_imd(tar, arg1, arg2)
	local rn = tonumber(arg2) or 0
	local line = ""

	if(0 == rn) then
		return "OK"
	end

	if(arg1 == tar) then
		line =  normal_cmd("RRLC", arg1, "R")

	else
		line =  normal_cmd("RRLC", arg1, "A")
		line = line .. "\n" .. normal_cmd("ATOR", tar)
	end

	for i = 2, rn do
		line = line  .. "\n" .. normal_cmd("RRLC", tar, "R")
	end

	return line
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
	["int8+=imd"] = math_int8_add_eq_imd,
	["int8+=int8"] = math_int8_add_eq_int8,
	["int8-=imd"] = math_int8_sub_eq_imd,
	["int8-=int8"] = math_int8_sub_eq_int8,
	["bit=imd"] = math_bit_eq_imd,
	["int8++"] = math_int8_incr,
	["int8--"] = math_int8_decr,
	["int8=int8>>imd"] = math_int8_rr_imd,
	["int8=int8>>>imd"] = math_int8_rrc_imd,
	["int8=int8<<imd"] = math_int8_rl_imd,
	["int8=int8<<<imd"] = math_int8_rlc_imd
}

function T.get(map)
        cmd_map = map
        return M
end

return T
