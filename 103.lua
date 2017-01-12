local T = {}

type_size = {
	["int8"] = 8
	}

type_map = {}


function T.math(line)
	print(line)
end

function T.new_var(type, name)
	local size = type_size[type]

	if(nil == size) then
		return nil, name .. " bad type: " .. type
	end

	type_map[name] = {}
	type_map[name]["type"] = type


	for bitn = 0, size - 1 do
		local bit_name = name .. "_b" .. bitn
		type_map[bit_name] = {}
		type_map[bit_name]["type"] = "bit"
	end

	print("new var " .. name .. " add OK.")
end

function T.get_var(name)
	return type_map[name]
end

return T
