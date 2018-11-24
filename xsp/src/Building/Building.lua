building={}
require "Building.Building_Research"
function building:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function building:ExitForm(ToRoot)
	tap(50,80)--左上角退出按钮
	if ToRoot then 
		local point = screen.findColor(Rect(5, 60, 98, 52), 
"0|0|0x5c3e2c,-4|24|0xfff8e2,-4|37|0xbe9357",
95, screen.PRIORITY_DEFAULT)
		if point.x>0 then
			Building:ExitForm(true) 
		end
	end
end