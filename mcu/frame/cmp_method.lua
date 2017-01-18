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



function cmp_imd(arg1, arg2, t, f)
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
		return string.format("%s\n%s\n%s\n%s", normal_cmd("RTOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JMPIFST", "Z"), normal_cmd("GOTO", f))
	end

	if(nil == f)then
		return cmp_int8_ne_int8(arg1,arg2, f, t)
	end
	
	return string.format("%s\n%s\n%s\n%s\n%s", normal_cmd("RTOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JMPIFST", "Z"), normal_cmd("GOTO", f), normal_cmd("GOTO", t))
end

function cmp_int8_ne_int8(arg1,arg2, t, f)
        local line 
        
        if(nil == t) then
                return string.format("%s\n%s\n%s\n%s", normal_cmd("RTOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JMPIFUST", "Z"), normal_cmd("GOTO", f))
        end

        if(nil == f)then
                return cmp_int8_eq_int8(arg1,arg2, f, t)
        end
        
        return string.format("%s\n%s\n%s\n%s\n%s", normal_cmd("RTOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JMPIFUST", "Z"), normal_cmd("GOTO", f), normal_cmd("GOTO", t))
end

function cmp_imd_eq_int8(arg1, arg2, t, f)

	local line

	if(nil == t) then
		return string.format("%s\n%s\n%s\n%s", normal_cmd("ITOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JMPIFST", "Z"), normal_cmd("GOTO", f))
	end

	if(nil == f)then
		return cmp_int8_ne_int8(arg1,arg2, f, t)
	end
	
	return string.format("%s\n%s\n%s\n%s\n%s", normal_cmd("ITOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JMPIFST", "Z"), normal_cmd("GOTO", f), normal_cmd("GOTO", t))
end

function cmp_imd_ne_int8(arg1,arg2, t, f)
        local line 
        
        if(nil == t) then
                return string.format("%s\n%s\n%s\n%s", normal_cmd("ITOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JMPIFUST", "Z"), normal_cmd("GOTO", f))
        end

        if(nil == f)then
                return cmp_int8_eq_int8(arg1,arg2, f, t)
        end
        
        return string.format("%s\n%s\n%s\n%s\n%s", normal_cmd("ITOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JMPIFUST", "Z"), normal_cmd("GOTO", f), normal_cmd("GOTO", t))
end

function cmp_int8_eq_imd(arg1,arg2, t, f)
	return cmp_imd_eq_int8(arg2,arg1, t, f)
end

function cmp_int8_ne_imd(arg1,arg2, t, f)
	return cmp_imd_ne_int8(arg2,arg2, t, f)
end

function cmp_imd_gt_int8(arg1,arg2, t, f)
        local line

        if(nil == t) then
                return string.format("%s\n%s\n%s\n%s", normal_cmd("ITOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JMPIFST", "C"), normal_cmd("GOTO", f))
        end

        if(nil == f)then
                return cmp_imd_le_int8(arg1,arg2, f, t)
        end

        return string.format("%s\n%s\n%s\n%s\n%s", normal_cmd("ITOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JMPIFST", "C"), normal_cmd("GOTO", f), normal_cmd("GOTO", t))
end

function cmp_imd_le_int8(arg1,arg2, t, f)
	local line

        if(nil == t) then
                return string.format("%s\n%s\n%s\n%s", normal_cmd("ITOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JMPIFUST", "C"), normal_cmd("GOTO", f))
        end

        if(nil == f)then
                return cmp_imd_gt_int8(arg1,arg2, f, t)
        end

        return string.format("%s\n%s\n%s\n%s\n%s", normal_cmd("ITOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JMPIFUST", "C"), normal_cmd("GOTO", f), normal_cmd("GOTO", t))
end

function cmp_imd_lt_int8(arg1,arg2, t, f)
	if(nil == t) then
                return string.format("%s\n%s\n%s\n%s", normal_cmd("RTOA", arg2), normal_cmd("ISUBA", arg1, "A"), normal_cmd("JMPIFST", "C"), normal_cmd("GOTO", f))
        end

        if(nil == f)then
                return cmp_imd_ge_int8(arg1,arg2, f, t)
        end

        return string.format("%s\n%s\n%s\n%s\n%s", normal_cmd("RTOA", arg1), normal_cmd("ISUBA", arg2, "A"), normal_cmd("JMPIFST", "C"), normal_cmd("GOTO", f), normal_cmd("GOTO", t))
end

function cmp_imd_ge_int8(arg1,arg2, t, f)
	if(nil == t) then
                return string.format("%s\n%s\n%s\n%s", normal_cmd("RTOA", arg2), normal_cmd("ISUBA", arg1, "A"), normal_cmd("JMPIFUST", "C"), normal_cmd("GOTO", f))
        end

        if(nil == f)then
                return cmp_imd_le_int8(arg1,arg2, f, t)
        end

        return string.format("%s\n%s\n%s\n%s\n%s", normal_cmd("RTOA", arg1), normal_cmd("ISUBA", arg2, "A"), normal_cmd("JMPIFUST", "C"), normal_cmd("GOTO", f), normal_cmd("GOTO", t))
end

function cmp_imd_lt_int8(arg1,arg2, t, f)
        return cmp_imd_le_int8(arg1, arg2, f, t)
end

function cmp_int8_gt_imd(arg1, arg2, t, f)
	return cmp_imd_lt_int8(arg2,arg1, t, f)
end

function cmp_int8_lt_imd(arg1, arg2, t, f)
	return cmp_imd_gt_int8(arg2, arg1, t, f)
end

function cmp_int8_ge_imd(arg1, arg2, t, f)
	return cmp_imd_le_int8(arg2, arg1, t, f)
end

function cmp_int8_le_imd(arg1, arg2, t, f)
	return cmp_imd_ge_int8(arg2, arg1, t, f)
end

function cmp_int8_gt_int8(arg1,arg2, t, f)
        local line

        if(nil == t) then
                return string.format("%s\n%s\n%s\n%s", normal_cmd("RTOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JMPIFST", "C"), normal_cmd("GOTO", f))
        end

        if(nil == f)then
                return cmp_imd_le_int8(arg1,arg2, f, t)
        end

        return string.format("%s\n%s\n%s\n%s\n%s", normal_cmd("RTOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JMPIFST", "C"), normal_cmd("GOTO", f), normal_cmd("GOTO", t))
end

function cmp_int8_le_int8(arg1,arg2, t, f)
        local line

        if(nil == t) then
                return string.format("%s\n%s\n%s\n%s", normal_cmd("RTOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JMPIFUST", "C"), normal_cmd("GOTO", f))
        end

        if(nil == f)then
                return cmp_imd_gt_int8(arg1,arg2, f, t)
        end

        return string.format("%s\n%s\n%s\n%s\n%s", normal_cmd("RTOA", arg1), normal_cmd("RSUBA", arg2, "A"), normal_cmd("JMPIFUST", "C"), normal_cmd("GOTO", f), normal_cmd("GOTO", t))
end

function cmp_int8_ge_int8(arg1,arg2, t, f)
	return cmp_int8_le_int8(arg2,arg1, t, f)
end

function cmp_int8_lt_int8(arg1,arg2, t, f)
	return cmp_int8_gt_int8(arg2,arg1, t, f)
end

function cmp_bit_eq_imd(arg1,arg2, t, f)
	if(nil == t)then
		if("0" == arg2)then
			return string.format("%s\n%s", normal_cmd("JMPIFUST", "C"), normal_cmd("GOTO", f))
		else
			return string.format("%s\n%s", normal_cmd("JMPIFST", "C"), normal_cmd("GOTO", f))
		end
	end
	
	if(nil == f)then
		return cmp_bit_ne_imd(arg2,arg1, f, t)
	end

	if("0" == arg2)then
		return string.format("%s\n%s\n%s", normal_cmd("JMPIFUST", "C"), normal_cmd("GOTO", f), normal_cmd("GOTO", t))
	else
		return string.format("%s\n%s\n%s", normal_cmd("JMPIFST", "C"), normal_cmd("GOTO", f), normal_cmd("GOTO", t))
	end
end

function cmp_bit_ne_imd(arg1,arg2, t, f)
        if(nil == t)then
                if("0" == arg2)then
                        return string.format("%s\n%s", normal_cmd("JMPIFST", "C"), normal_cmd("GOTO", f))
                else
                        return string.format("%s\n%s", normal_cmd("JMPIFUST", "C"), normal_cmd("GOTO", f))
                end
        end
        
        if(nil == f)then
                return cmp_bit_ne_imd(arg2,arg1, f, t)
        end

        if("0" == arg2)then
                return string.format("%s\n%s\n%s", normal_cmd("JMPIFST", "C"), normal_cmd("GOTO", f), normal_cmd("GOTO", t))
        else
                return string.format("%s\n%s\n%s", normal_cmd("JMPIFUST", "C"), normal_cmd("GOTO", f), normal_cmd("GOTO", t))
        end
end

function cmp_imd_eq_bit(arg1,arg2, t, f)
	return cmp_bit_eq_imd(arg2,arg1, t, f)
end

function cmp_imd_ne_bit(arg1,arg2, t, f)
	return cmp_bit_ne_imd(arg2,arg1, t, f)
end


local M  = {
	["imd"] = cmp_imd,
	["int8==int8"] = cmp_int8_eq_int8,
	["int8!=int8"] = cmp_int8_ne_int8,
	["imd==int8"] = cmp_imd_eq_int8,
	["imd!=int8"] = cmp_imd_ne_int8,
	["int8==imd"] = cmp_int8_eq_imd,
	["int8!=imd"] = cmp_int8_ne_imd,
	["imd==bit"] = cmp_imd_eq_bit,
	["imd!=bit"] = cmp_imd_ne_bit,
	["bit==imd"] = cmp_bit_eq_imd,
	["bit!=imd"] = cmp_bit_ne_imd,
	["imd>int8"] = cmp_imd_gt_int8,
	["imd>=int8"] = cmp_imd_ge_int8,
	["imd<int8"] = cmp_imd_lt_int8,
	["imd<=int8"] = cmp_imd_le_int8,
	["int8>imd"] = cmp_int8_gt_imd,
	["int8>=imd"] = cmp_int8_ge_imd,
	["int8<imd"] = cmp_int8_lt_imd,
	["int8<=imd"] = cmp_int8_le_imd,
	["int8>int8"] = cmp_int8_gt_int8,
	["int8>=int8"] = cmp_int8_ge_int8,
	["int8<int8"] = cmp_int8_lt_int8,
	["int8<=int8"] = cmp_int8_le_int8
}

local T = {}

function T.get(map)
	cmd_map = map
	return M
end

return T
