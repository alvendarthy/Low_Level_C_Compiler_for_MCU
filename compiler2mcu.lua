util = require "util.util"
serialize = require "util.serialize"

if(#arg ~= 3) then
	print([[
usage: 
	lua script.lua in out var_tabel_file]])
	return
end



local log = print
local src_name = arg[1]
local out_name = arg[2]
local var_tab_file = arg[3]

local codes = {}

local src_f, err = io.open(src_name, "r")
if(err) then
	log("cannot open " .. src_name .. ": " .. err)
	return
end

local out_f, err = io.open(out_name, "w")
if(err) then
        log("cannot open " .. out_name .. ": " .. err)
        return
end

local var_tab_f = io.open(var_tab_file, "w")
if(err) then
        log("cannot open " .. out_name .. ": " .. err)
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

function compile_job(codes)
	local linenum, code
	local pos
	local loaded
	local ret, msg
	for linenum, code in ipairs(codes) do
		loaded, msg = loadstring("return " .. code)
		if(nil == loaded) then
			msg = "bad code. " .. msg .. "[" .. linenum .. "]"
			log(msg)
			return nil, msg
		end

		ret, msg = loaded()

		if("code" == ret) then
			if(type(msg) == "table") then
				for _, code in pairs(msg) do
					out_f:write(code)
					out_f:write('\n')
				end
			elseif (type(msg) == "string") then
					code = msg
					out_f:write(code)
					out_f:write('\n')
			else
				log("bad code:" .. code)
			end
		elseif ("ok" == ret) then
		else
			print("bad code:" .. msg)
		end

	end

	return "ok"
end

function show_all_vars()
	local vars = util.get_var_map()
	for var_name, info in pairs (vars) do
		print(var_name .. " type: " .. info.type .. " addr: " .. info.addr .. " bit_addr: " .. info.bitaddr)
	end
end

load_src_file(src_f, codes)
compile_job(codes)

local vars = util.get_var_map()
local serialized_var_tab = serialize(vars)

if(nil == serialized_var_tab) then
	print("serialize var tab failed.")
	var_tab_f:close()
	src_f:close()
	out_f:close()
	return
end

var_tab_f:write(serialized_var_tab)

var_tab_f:close()
src_f:close()
out_f:close()
