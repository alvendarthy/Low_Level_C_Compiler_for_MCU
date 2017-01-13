local T = {}

type_size = {
	["int8"] = 8
	}

var_map = {}


function T.math(line)
	print(line)
end

function T.new_var(type, name)
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

	return "ok", "ok"
end

function T.get_var(name)
	return var_map[name]
end

function T.get_var_map()
	return var_map
end

return T
