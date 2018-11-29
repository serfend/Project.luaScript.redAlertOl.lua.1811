
function CityBuilding:CheckFreeQueueNum()
	self.anyFreeQueueNum=0
	local point = screen.findColor(Rect(27, 188, 57, 49), 
"0|0|0x99a7c8,-7|8|0x99a7c8,-18|18|0xe2edfd",
95, screen.PRIORITY_DEFAULT)--第一个锤子
	if point.x>0 then
		self.ConstructQueueFree[1]=true
	end
	point = screen.findColor(Rect(32, 292, 48, 58), 
"0|0|0xbf904b,-7|3|0xc2924c,-18|-2|0xf8efd6",
95, screen.PRIORITY_DEFAULT)
	if point.x>0 then
		self.ConstructQueueFree[2]=true
	end
end