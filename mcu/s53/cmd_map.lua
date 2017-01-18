
function ator(cmd, arg1, arg2)
	if(arg1 == "OPTION")then
		return "OPTION", nil, nil
	end

	if(arg1 == "IOST")then
                return "IOST", nil, nil
        end

	return "MOVR", arg1, arg2
end



return {
	["RTOA"]="MOVAR",
	["ATOR"]= ator,
	["BSTR"] = "BSR",
	["CLRR"] = "CLRR",
	["ITOA"] = "MOVIA",
	["JMPIFST"] = "BTRSS",
	["JMPIFUST"] = "BTRSC",
	["RINCR"] = "INCR",
	["RDECR"] = "DECR",
	["RSUBA"] = "SUBAR",
	["ISUBA"] = "SUBIR",
	["RADDA"] = "ADDAR",
	["IADDA"] = "ADDIA",
	["CLRWDT"] = "CLRWDT",
	["NOP"] = "NOP"
}
