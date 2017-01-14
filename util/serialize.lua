local function serialize (t)
	local mark={}  
	local assign={}  
	local function ser_table(tbl,parent)  
		mark[tbl]=parent  
		local tmp={}  
		for k,v in pairs(tbl) do  
			local key= type(k)=="number" and "["..k.."]" or "[".. string.format("%q", k) .."]"  
			if type(v)=="table" then  
				local dotkey= parent.. key  
				if mark[v] then  
					table.insert(assign,dotkey.."='"..mark[v] .."'")  
				else  
					table.insert(tmp, key.."="..ser_table(v,dotkey))  
				end  
			elseif type(v) == "string" then  
				table.insert(tmp, key.."=".. string.format('%q', v))  
			elseif type(v) == "number" or type(v) == "boolean" then  
				table.insert(tmp, key.."=".. tostring(v))  
			end  
		end  
		return "{"..table.concat(tmp,",").."}"  
	end

	return "do local ret="..ser_table(t,"ret")..table.concat(assign," ").." return ret end" 
end

return serialize
