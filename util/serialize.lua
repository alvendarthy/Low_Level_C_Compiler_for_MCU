local function serialize (t)
	local function ser_table(tbl)  
		local tmp={}  
		for k,v in pairs(tbl) do  
			local key= type(k)=="number" and "["..k.."]" or "[".. string.format("%q", k) .."]"  
			if type(v)=="table" then  
				local dotkey= key  
				table.insert(tmp, key.."="..ser_table(v,dotkey))  
			elseif type(v) == "string" then  
				table.insert(tmp, key.."=".. string.format('%q', v))  
			elseif type(v) == "number" or type(v) == "boolean" then  
				table.insert(tmp, key.."=".. tostring(v))  
			end  
		end  
		return "{"..table.concat(tmp,",").."}"  
	end

	return "return "..ser_table(t,"ret")
end

return serialize
