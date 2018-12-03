
normal={
	InDanger=false
}
function normal:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function normal:UseProtect()
	local point = screen.findColor(Rect(503, 327, 157, 378), 
"0|0|0x2d4372,101|-4|0x2a3d69",
95, screen.PRIORITY_DEFAULT)
	if point.x<0 then
		ShowInfo.RunningInfo("当前无防护罩可用")
	else
		tap(point.x+100,point.y+30)
	end
end
function normal:StartProtect()
	MainForm:ExitForm()
	Building.building:Navigate("建筑工厂")
	local point = screen.findColor(Rect(340, 687, 150, 179), 
"0|0|0xc9a96f,34|-18|0xbe9e66,34|7|0xd2b175,34|25|0xe7c283",
95, screen.PRIORITY_DEFAULT)
	if point.x>0 then
		tap(point.x,point.y)
		sleep(500)
		tap(354,233)
		sleep(500)
		self:UseProtect()
		return true
	else
		ShowInfo.RunningInfo("寻找保护罩按钮失败")
		return false
	end
end

local noneDangerTime=0
--@summary:检测是否有敌人来犯
function normal:CheckIfAnyEnemyConquer()
	local point = screen.findColor(Rect(588, 1252, 103, 24), 
"0|0|0xc61c15,-30|-1|0xd91b14,-57|-1|0xd91b14",
95, screen.PRIORITY_DEFAULT)
	if point.x>0  then
		ShowInfo.RunningInfo("发现来犯敌人")
		tap(45,668)--进入情报查看
		sleep(500)
		point = screen.findColor(Rect(20, 300, 29, 56), 
"0|0|0xa82817,0|14|0x892413,0|25|0x731f0e,9|32|0x6b2016",
95, screen.PRIORITY_DEFAULT)
		if point.x>0 then--确实为攻击
			
			ShowInfo.RunningInfo("正在遭到攻击")
			self:StartProtect()
			return true
		else
			self.InDanger=true
			noneDangerTime=0
			ShowInfo.RunningInfo("遭到侦查,进入全程监控模式")
			MainForm:ExitForm()
			return false
		end
	else
		noneDangerTime=noneDangerTime+1
		if noneDangerTime>30 then
			self.InDanger=false
		end
		return false
	end
end


--@summary:判断是否有建筑可免费完成
function normal:CheckAnyFreeBuilding()
	local point = screen.findColor(Rect(12, 171, 77, 227), 
"0|0|0x2a6f1f,2|20|0x257c15,2|48|0x25910e",
95, screen.PRIORITY_DEFAULT)
	if point.x>0 then
		tap(point.x,point.y)
		sleep(800)
		if normal:CheckAnyFreeBuilding() then
			Building.building.Run(true)--建筑空闲，进入一轮
		end
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