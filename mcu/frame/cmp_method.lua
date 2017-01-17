
local cmd_map = {}

function normal_cmd(cmd, arg1, arg2)
        cmd = cmd_map[cmd] or cmd
        if(nil == arg1) then
                return string.format("\t%-16s %-16s %-16s", cmd, "","")
        elseif(nil == arg2)then
                return string.format("\t%-16s %-16s %-16s", cmd, arg1,"")
        else
                return string.format("\t%-16s %-16s %-16s", cmd, arg1 .. ",",arg2)
        end
end



function cmp_d(arg1, arg2, t, f)
        if(t and arg1 ~= "0") then
                return normal_cmd("GOTO", t)
        end

        if(f and arg1 == "0") then
                return normal_cmd("GOTO", f)
        end

        return nil
end


local M  = {
	["imd"] = cmp_d
}

local T = {}

function T.get(map)
	cmd_map = map
	return M
end

return T
