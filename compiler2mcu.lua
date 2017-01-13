util = require "util.util"

log = print
src_name = "a.out"

local codes = {}

local src_f, err = io.open(src_name, "r")
if(err) then
	log("cannot open " .. src_name .. ": " .. err)
	return
end

function load_src_file(file, tab)
	local code
	for code in file:lines() do
		table.insert(tab, code)
	end
end



function cat_codes(tab)
	local code
	for _, code in pairs(tab)do
		log(code)
	end
end

function scan_new_vars(codes)
	local linenum, code
	local pos
	local loaded
	local ret, msg
	for linenum, code in ipairs(codes) do
		if(string.find(code, "util.new_var(.*)"))then
			loaded, msg = loadstring("return " .. code)
			if(nil == loaded) then
				msg = "bad code. " .. msg .. "[" .. linenum .. "]"
				log(msg)
				return nil, msg
			end
			ret, msg = loaded()
			if(nil == ret) then
				log(msg)
				--return nil, msg
			end
		end
	end

	return "ok"
end

function show_all_vars()
	local vars = util.get_var_map()
	local var_name, info
	for var_name, info in pairs (vars) do
		print(var_name .. " type: " .. info.type)
	end
end

load_src_file(src_f, codes)
scan_new_vars(codes)
show_all_vars()


src_f:close()
