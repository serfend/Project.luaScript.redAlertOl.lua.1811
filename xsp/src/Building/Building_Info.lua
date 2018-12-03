
function CityBuilding:CheckFreeQueueNum()
	self.anyFreeQueueNum=0
	local point = screen.findColor(Rect(27, 200, 47, 43), 
"0|0|0xe3eefd,0|-4|0xe8f1fe,-6|-4|0xe8f1fe,-6|1|0xe2edfd",
95, screen.PRIORITY_DEFAULT)
	--第一个锤子
	if point.x>0 then
		ShowInfo.ResInfo("建筑队列1可用")
		self.ConstructQueueFree[1]=true
	end
	point = screen.findColor(Rect(32, 292, 48, 58), 
"0|0|0xbf904b,-7|3|0xc2924c,-18|-2|0xf8efd6",
95, screen.PRIORITY_DEFAULT)
	if point.x>0 then
		ShowInfo.ResInfo("建筑队列2可用")
		self.ConstructQueueFree[2]=true
	end
end
