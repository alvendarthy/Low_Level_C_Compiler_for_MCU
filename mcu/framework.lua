util = require "util.util"

local F = {}

F.cmd = {
}

function cmp_d(arg1, arg2, t, f)
	if(t and arg1 ~= "0") then
		return F.normal_cmd("GOTO", t)
	end

	if(f and arg1 == "0") then
		return F.normal_cmd("GOTO", f)
	end

	return nil
end


function F.get_var_type(var)
	if(util.is_number_str(var))then
		return "IMD"
	end

	local info  = F.var[var]
	if(nil == info)then
		return nil, "bad var"
	end

	return info.type
end

F.cmp_method = {
	["INT8==INT8"] = cmp_i_eq_i,
	["IMD"] = cmp_d
--[[	["IMD==INT8"] = cmp_deqi,
	["INT8==IMD"] = cmp_ieqd,
	["INT8~=INT8"] = cmp_ne,
	["INT8>INT8"] =  cmp_gt,
	["INT8>=INT8"] = cmp_ge,
	["INT8<INT8"] = cmp_lt,
	["INT8<=INT8"] = cmp_le,
	["IMD"] = cmp_imd ]]--
}

function F.normal_cmd(cmd, arg1, arg2)
	cmd = F.cmd[cmd] or cmd
	if(nil == arg1) then
		return string.format("\t%-16s %-16s %-16s", cmd, "","")
	elseif(nil == arg2)then
		return string.format("\t%-16s %-16s %-16s", cmd, arg1,"")
	else
		return string.format("\t%-16s %-16s %-16s", cmd, arg1 .. ",",arg2)
	end
end

function F.get_function_label(name)
	return "FUNCTION_" .. name
end

function F.code_label(lab)
	return "code", lab .. ":"
end

function F.code_goto(addr)
	local cmd = F.cmd["GOTO"] or "GOTO"
	local line = F.normal_cmd("GOTO", addr)
	return "code", line
end

function F.code_func_bgn(addr)
	return "code", F.get_function_label(addr) .. ":"
end

function F.code_func_end(addr)
	return "code", F.get_function_label(addr).. "_END:"
end

function F.call_func(name)
	local cmd = F.cmd["CALL"] or "CALL"
	local line = F.normal_cmd("CALL", F.get_function_label(name))
        return "code", line
end

function F.code_return(arg)
	local cmd = F.cmd["RETURN"] or "RETURN"
	local line = F.normal_cmd("RETURN")
        return "code", line
end

function F.code_code_at(addr)
	local cmd = F.cmd["ORG"] or "ORG"
	local line = F.normal_cmd("ORG", addr)
        return "code", line
end

function F.code_jmp(exp, t, f)
	local arg1, op, arg2 = string.match(exp, "([%w%d_]+)([%W]*)([%w%d_]*)")
	if(op .. arg2 == "")then
		local ty, msg = F.get_var_type(arg1)
		if(nil == ty)then
			return nil, msg
		end
		local line = F.cmp_method[ty](arg1, arg2, t, f)
		if(line) then
			return "code", line
		else
			return "ok"
		end

		return nil, "bad code"
	end
	
	return "ok"
end


--[[
cmp_ne
cmp_gt
cmp_ge
cmp_lt
cmp_le
cmp_imd
]]--


return F
