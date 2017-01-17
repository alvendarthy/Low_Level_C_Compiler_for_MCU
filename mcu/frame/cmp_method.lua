
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



function cmp_d(arg1, arg2, t, f)
        if(t and arg1 ~= "0") then
                return normal_cmd("GOTO", t)
        end

        if(f and arg1 == "0") then
                return normal_cmd("GOTO", f)
        end

        return nil
end

function cmp_int8_eq_int8(arg1, arg2, t, f)

	local line

	if(nil == t) then
		return string.format("%s\n%s\n%s\n%s", normal_cmd("RTOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JUMPIFST", "C"), normal_cmd("GOTO", f))
	end

	if(nil == f)then
		return cmp_int8_ne_int8(arg1,arg2, f, t)
	end
	
	return string.format("%s\n%s\n%s\n%s\n%s", normal_cmd("RTOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JUMPIFST", "C"), normal_cmd("GOTO", f), normal_cmd("GOTO", t))
end

function cmp_int8_ne_int8(arg1,arg2, t, f)
        local line 
        
        if(nil == t) then
                return string.format("%s\n%s\n%s", normal_cmd("RTOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JUMPIFUST", "C"), normal_cmd("GOTO", f))
        end

        if(nil == f)then
                return cmp_int8_eq_int8(arg1,arg2, f, t)
        end
        
        return string.format("%s\n%s\n%s", normal_cmd("RTOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JUMPIFUST", "C"), normal_cmd("GOTO", f), normal_cmd("GOTO", t))
end


local M  = {
	["imd"] = cmp_d,
	["int8==int8"] = cmp_int8_eq_int8,
	["int8!=int8"] = cmp_int8_ne_int8
}

local T = {}

function T.get(map)
	cmd_map = map
	return M
end

return T
