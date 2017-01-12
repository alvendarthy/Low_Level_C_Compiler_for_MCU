mcu = require "103"


loadstring('mcu.math("a=a+2")')()
loadstring('mcu.new_var("int8", "a")')()

local var = mcu.get_var("a_b1")
if(nil == var) then
	print("a not found.")
else
	print("a, type=" .. var.type)
end
