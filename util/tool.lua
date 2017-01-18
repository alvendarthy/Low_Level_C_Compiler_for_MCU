local T = {}

local cmd_map = {}

function T.normal_cmd(cmd, arg1, arg2)
        cmd = cmd_map[cmd] or cmd
        if(nil == arg1) then
                return string.format("\t%-16s %-16s %-16s", cmd, "","")
        elseif(nil == arg2)then
                return string.format("\t%-16s %-16s %-16s", cmd, arg1,"")
        else
                return string.format("\t%-16s %-16s %-16s", cmd, arg1 .. ",",arg2)
        end
end

function T.set_cmd_map(map)
	cmd_map = map
end


return T
