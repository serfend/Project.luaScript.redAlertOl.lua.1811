
normal={
	InDanger=false
}
function normal:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
--@summary:在开罩页面时，使用防护罩
function normal:UseProtect()
	local point = screen.findColor(Rect(503, 327, 157, 378), 
"0|0|0x2d4372,101|-4|0x2a3d69",
95, screen.PRIORITY_DEFAULT)
	if point.x<0 then
		ShowInfo.RunningInfo("当前无防护罩可用")
	else
		showRectPos(point.x+100,point.y+30)
	end
end
--@summary:常规模式开罩
function normal:StartProtectOnBase()
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
--@summary:以侦察模式检查，决定开启防护或撤军
function normal:StartProtect(targetY)
	tap(621,targetY)--点击查看按钮
	sleep(1000)
	tap(186,458)--坐标点按钮
	sleep(1000)
	pandect:SelectCurrentTarget(5)
	sleep(500)
	local point = screen.findColor(Rect(30, 61, 72, 52), 
"0|0|0xfffdf4,25|8|0x6d4e31,11|17|0x8d683c",
95, screen.PRIORITY_DEFAULT)--检查是否在开罩界面
	if point.x>0 then
		tap(354,233)
		sleep(500)
		self:UseProtect()
	else
		ShowInfo.ResInfo("已从野矿撤军")
	end
end
local noneDangerTime=0
--@summary:检测是否有敌人来犯
function normal:CheckIfAnyEnemyConquer()
	local r,g,b=screen.getRGB(628,1273)--红色判断点1
	local r2,g2,b2=screen.getRGB(674,1270)--红色判断点1
	if r>120 and r2>120 and g<40 and g2<40 then
		ShowInfo.RunningInfo("发现来犯敌人")
		MainForm:ExitForm(true)
		sleep(500)
		tap(45,668)--进入情报查看
		sleep(500)
		self:MonitorON()
		return true
	end
	return false
end

local firstY=342--情报页面  344为第一个，每个间距154
local intervalY=154

--@summary:在情报页面时，进行监控侦察和攻击，直到安全
--当发现被侦察时，进行继续监控
--当发现被攻击时，做出决策
function normal:MonitorON()
	while true do
		local enemys,enemy,detect=self:CheckEnemyConquerCount()
		ShowInfo.RunningInfo(string.format("入侵监控 侦察:%d,攻击:%d",detect,enemy))
		if enemy>0 then--执行防御模式
			for i,k in ipairs(enemys) do
				if k.attack then
					self:StartProtect(k.index*intervalY+firstY)
					ResetForm()
					break
				end
			end
			break
		else
			if detect>0 then
				
			else
				ShowInfo.RunningInfo("危险解除")
				sleep(1000)
				ResetForm()
				break
			end
		end
		sleep(500)
	end
end

--@summary:检查当前来犯敌人类型
function normal:CheckEnemyConquerCount()
	
	local judgeX=35
	local result={[1]={},[2]={},[3]={}}
	local enemyCount={0,0,0}--攻击数量
	local detectCount={0,0,0}--侦察数量
	for times=1,3 do--检查3次防红色警报污染
		for i=0,5 do--检查前6个情报
			local ensureEnemy=0
			local ensureDetect=0
			for j=0,2 do
				local r,g,b=screen.getRGB(judgeX,firstY+i*intervalY+j)
				if r>100 and g>50 then--黄色为侦察
					ensureDetect=ensureDetect+1
				else
					if r>100 and g<50 then--红色为攻击
						ensureEnemy=ensureEnemy+1
					end
				end
			end
			if ensureDetect==3 then
				table.insert(result[times],{index=i,attack=false})
				detectCount[times]=detectCount[times]+1
			else
				if ensureEnemy==3 then
					table.insert(result[times],{index=i,attack=true})
					enemyCount[times]=enemyCount[times]+1
				end
			end
		end
		sleep(500)
	end
	for i=2,3 do
		if not enemyCount[i]==enemyCount[i-1] then--当敌人数量不符时，重检查	
			return self:CheckEnemyConquerCount()
		end
	end
	return result[1],enemyCount[1],detectCount[1]
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