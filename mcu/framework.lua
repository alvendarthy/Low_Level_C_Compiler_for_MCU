local F = {}

function F.out_CMD_1_ARG(cmd, arg1)
	return string.format("\t%-16s %-16s", cmd, arg1)
end

function F.get_function_label(name)
	return "FUNCTION_" .. name
end

function F.code_label(lab)
	return "code", lab .. ":"
end

function F.code_goto(addr)
	local line = F.out_CMD_1_ARG("GOTO", addr)
	return "code", line
end

function F.code_func_bgn(addr)
	return "code", F.get_function_label(addr) .. ":"
end

function F.code_func_end(addr)
	return "code", F.get_function_label(addr).. "_END:"
end

function F.call_func(name)
	local line = F.out_CMD_1_ARG("CALL", F.get_function_label(name))
        return "code", line
end

function F.code_return(arg)
	local line = F.out_CMD_1_ARG("RETURN", "")
        return "code", line
end
return F
