local Stack = require "util.stack"

local T = {}


local type_size = {
	["int8"] = 8
	}

local var_map = {}
local label_stack = Stack:new()
local if_stack = Stack:new()
local while_stack = Stack:new()

function T.code_math(line)
	print(line)
end

function T.code_new_var(type, name)
	local size = type_size[type]

	if(nil == size) then
		return nil, name .. " bad type: " .. type
	end

	if(T.get_var(name))then
		return nil, "var: " .. name .. " is redefined."
	end

	var_map[name] = {}
	var_map[name]["type"] = type
	var_map[name]["name"] = name


	for bitn = 0, size - 1 do
		local bit_name = name .. "_b" .. bitn
		var_map[bit_name] = {}
		var_map[bit_name]["type"] = "bit"
		var_map[bit_name]["name"] = bit_name
	end

	return "ok"
end

function get_label_id(label)
	local id = string.match(label, "LABEL_(%d+)_")
        if(nil == id) then
                return nil, "bad while_bgn code"
        end

	return id
end

function T.code_while_bgn(label)
	local id, msg = get_label_id(label)
	if(nil == id) then
		return id, msg
	end

	while_stack:push(id)
	return "ok"
end

function T.code_while_end(label)
	local id, msg = get_label_id(label)
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

	return "code", "mcu.label(" .. label .. ")"
end

function T.code_logical(exp)
	return "code", {"logical exp start", exp, "logical exp end"}
end

function T.get_var(name)
	return var_map[name]
end

function T.get_var_map()
	return var_map
end

return T
