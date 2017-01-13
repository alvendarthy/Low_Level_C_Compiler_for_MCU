local Stack = require "util.stack"

local T = {}

local byte_nbit = 8

local type_size = {
	["int8"] = 8
	}

local var_map = {}
local label_stack = Stack:new()
local if_stack = Stack:new()
local while_stack = Stack:new()

local cur_code_pointer = 0
local cur_ram_pointer = 0

function ram_addr_auto_add(ty)
	local size =  math.floor(type_size[ty] / byte_nbit)
	cur_ram_pointer = cur_ram_pointer + size
end

function T.code_new_var(ty, name)
	local size = type_size[ty]

	if(nil == size) then
		return nil, name .. " bad type: " .. ty
	end

	if(T.get_var(name))then
		return nil, "var: " .. name .. " is redefined."
	end

	var_map[name] = {}
	var_map[name]["type"] = ty
	var_map[name]["name"] = name
	var_map[name]["addr"] = cur_ram_pointer


	for bitn = 0, size - 1 do
		local bit_name = name .. "_b" .. bitn
		var_map[bit_name] = {}
		var_map[bit_name]["type"] = "bit"
		var_map[bit_name]["name"] = bit_name
		var_map[bit_name]["addr"] = cur_ram_pointer
	end

	ram_addr_auto_add(ty)

	return "ok"
end

function get_label_info(label)
	local id  = string.match(label, "LABEL_(%d+)_")
        if(nil == id) then
                return nil, nil, "bad while_bgn code"
        end

	return id, ty
end

function T.code_while_bgn(label)
	local id, msg = get_label_info(label)
	if(nil == id) then
		return id, msg
	end

	while_stack:push(id)
	return "ok"
end

function T.code_while_end(label)
	local id, msg = get_label_info(label)
	if(nil == id) then
		return id, msg
	end

	while_stack:pop(id)
	return "ok"
end

function T.code_break()
	local id = while_stack:top()
	if(nil == id) then
		return nil, "wrong break exp, should be in loop expressions."
	end

	return "code", "mcu.code_goto(LABEL_" .. id .. "_END)"
end

function T.code_continue()
	local id = while_stack:top()
	if(nil == id) then
		return nil, "wrong break exp, should be in loop expressions."
	end

	return "code", "mcu.code_goto(LABEL_" .. id .. "_TRUE_BGN)"
end

function T.code_label(label)
	if(nil == label)then
		return nil, "bad label:" .. label
	end

	local id = get_label_info(label)
        if(nil == id) then
                return nil, "bad label" .. label
        end

	if(string.find(label, "_BGN$")) then
		label_stack:push(id)
	elseif (string.find(label, "_END$")) then
		label_stack:pop(id)
	end

	return "code", "mcu.code_label(" .. label .. ")"
end

function is_number_str(str)
	if string.match(str, "^%d+$") then 
		return true
	else
		return false
	end
end

local push_code = table.insert

function check_var(exp)
	local rest = exp
	local var
	local ret = "ok"

	while(1) do
		if nil == rest then
			break
		end
		var, rest = string.match(rest, "([%d%a_]+)(.*)")
		if(nil == var) then
			break
		end

		if(not is_number_str(var))then
			if(not T.get_var(var)) then
				ret = nil
				print("undefined var: " .. var)
			end
		end
	end

	return ret
end


function T.code_logical(exps)
	local exp, logi_con, rest

	local ret_codes = {}
	local id = label_stack:top()
	local true_label =  "LABEL_" .. id .. "_TRUE_BGN"
	local false_label = "LABEL_" .. id .. "_FALSE_BGN"

	local ret

	rest = exps

	while( 1 )do

		if nil == rest then
			break
		end

		exp, logi_con, rest = string.match(rest,"([^|&]+)([|&]*)(.*)")
		if(nil == exp)then
			break
		end

		logi_con = logi_con or "";

		check_var(exp)
		
		if(logi_con == "" or logi_con == "&&") then
			push_code(ret_codes, "mcu.code_jmp(\"" .. exp .."\", nil, \"" .. false_label .. "\")")
		elseif(logi_con == "||") then
			push_code(ret_codes, "mcu.code_jmp(\"" .. exp .."\", \"" .. true_label .. "\", nil)")
		end
	end

	return "code", ret_codes
end


function T.code_math(line)
	check_var(line)
	return "code", "mcu.code_math(\"" .. line .. "\")"
end

function T.get_var(name)
	return var_map[name]
end

function T.get_var_map()
	return var_map
end

function T.code_ram_at(addr)
	cur_ram_pointer = addr
	return "ok"
end


function T.code_code_at(addr)
	cur_code_pointer = addr
	return "code", "mcu.code_code_at(" .. addr .. ")"
end

function T.code_if_bgn(lab)
	return "ok"
end

function T.code_if_end(lab)
	return "ok"
end

function T.code_goto(addr)
	return "code", "mcu.code_goto(\"" .. addr .. "\")"
end
return T
