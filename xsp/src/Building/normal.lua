
normal={}
function normal:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function normal:CheckAnyFreeBuilding()
	local point = screen.findColor(Rect(12, 171, 77, 227), 
"0|0|0x2a6f1f,2|20|0x257c15,2|48|0x25910e",
95, screen.PRIORITY_DEFAULT)
	if point.x>0 then
		tap(point.x,point.y)
		return true
	else
		return false
	end
end

function normal:CheckAnyBuildingButton()
	local point = screen.findColor(Rect(89, 177, 579, 956), 
"0|0|0x8b8a77,0|-7|0x492617,-4|-69|0x2c2222,25|-38|0x231a1a,-29|-37|0x35251e",
95, screen.PRIORITY_DEFAULT)
	if point.x>0 then
		tap(point.x,point.y)
		return true
	else
		return false
	end
end