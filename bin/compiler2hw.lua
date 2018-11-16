util = require "util.util"
serialize = require "util.serialize"


if(#arg ~= 4) then
	print([[
usage: 
	lua script.lua in out var_tabel_file]])
	return
end



local log = print
local src_name = arg[3]
local out_name = arg[4]
local var_tab_file = arg[2]
local mcu_name = arg[1]

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

local var_map = require(var_tab_file)
if(nil == var_map) then
	log("cannot open vars file.")
	return
end

local mcu_factory = require(mcu_name)
if(nil == mcu_factory) then
	log("cannot open mcu factory.")
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
	local vars = var_map
	for var_name, info in pairs (vars) do
		print(var_name .. " type: " .. info.type .. " addr: " .. info.addr .. " bit_addr: " .. info.bitaddr)
	end
end

function all_var_defs(f, vars)
	for var_name, info in pairs (vars) do
		if(info.type == "int8")then
			f:write(info.name .. " EQ " .. info.addr .. "\n")
		elseif (info.type == "bit") then
			f:write("#define " .. info.name .. " " .. info.addr .. ", " .. info.bitaddr .. "\n")
		end
        end
end

mcu = mcu_factory:get(var_map)

load_src_file(src_f, codes)

all_var_defs(out_f, var_map)
--show_all_vars()

compile_job(codes)
src_f:close()
out_f:close()
