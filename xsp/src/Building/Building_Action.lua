
local queueButtonY,queueButtonX=182,13
function CityBuilding:SelectConstructQueue(index)
	tap(queueButtonX+30,queueButtonY+30+(index-1)*100)
end

--@summary:建筑升级流程
function CityBuilding:UpLevelBuilding()
	for i=1,2 do
		if self.ConstructQueueFree[i] then
			ShowInfo.ResInfo(string.format("建筑%d队作业开始",i))
			if Setting.Building.UseRecommand then
				ShowInfo.RunningInfo("按系统推荐建筑")
				self:SelectConstructQueue(i)
				sleep(1000)
				if not self:NowSelectBuildingUplevel() then
					if self:UpLevelBuildingByPriority() then
						sleep(1000)
					end
				end
			else
				self:UpLevelBuildingByPriority()
			end
		end
	end
end

--@summary:升级当前选中的建筑
function CityBuilding:NowSelectBuildingUpLevel()
	local point = screen.findColor(Rect(38, 392, 635, 813), 
"0|0|0xc2a26b,-15|16|0xd3b278,16|18|0xd5b378,1|15|0xd1b177,-8|35|0xedc98b,11|36|0xefcb8b",
95, screen.PRIORITY_DEFAULT)
	if point.x>0 then
		tap(point.x,point.y+30)
		sleep(1000)
		for i=1,3 do
			local r,g,b=screen.getRGB(496,796+70*i)--条件的【叉】位置
			if r>220 and g<100 and b<100 then
				ShowInfo.ResInfo("建筑暂不可升级")
				MainForm:ExitForm()
				return false
			end
		end
		tap(524,1177)--立即升级
		sleep(1000)
		tap(354,451)--修复点击后会退出界面，提出【联盟帮助】
		return true
	else
		ShowInfo.ResInfo("建筑暂无升级按钮")
		return false
	end
end

--@summary:依据设置的优先级进行升级
function CityBuilding:UpLevelBuildingByPriority()
	ShowInfo.RunningInfo("优先级建筑")
	local buildingInPriority={}
	for i=1,7 do
		buildingInPriority[i]={}
	end
	for index,v in ipairs(Setting.Building.List) do
		table.insert(buildingInPriority[v.Priority],v)
	end
	for i=1,7 do
		if buildingInPriority[i] then
			for index,building in ipairs(buildingInPriority[i]) do
				ShowInfo.ResInfo(string.format("%d级:%s 开始",i,building.Name))
				if self:RunBuilding(building.Name) then
					ShowInfo.ResInfo(string.format("%s 完成",building.Name))
					return true
				end
			end
		end
	end
end
function CityBuilding:RunBuilding(buildingName)
	self:Navigate(buildingName)
	local success=self:NowSelectBuildingUpLevel()
	return success
end

function CityBuilding:ReEnterCity()
	tap(65,1233)
	sleep(1500)
	ResetForm()
end
function CityBuilding:Navigate(buildingName)
	self:ReEnterCity()
	if not self:CheckIfActualyInPoint() then
		ShowInfo.ResInfo("处理总览以修正坐标")
		Building.pandect:NewCheckPandect(true)
		self:ReEnterCity()
	end
	ShowInfo.ResInfo(string.format("寻找建筑:%s",buildingName))
	sleep(500)
	local targetX,targetY=CityMap[buildingName].x,CityMap[buildingName].y
	self:NavigateScreen(targetX,targetY)
	tap(360,640)
	sleep(1000)
end
--@summary:检查是否真的在主基地处
function CityBuilding:CheckIfActualyInPoint()
	local point = screen.findColor(Rect(103, 640, 277, 273), 
"0|0|0x499bac,-26|-34|0xf7f1db",
95, screen.PRIORITY_DEFAULT)
	return point.x>0
end
function CityBuilding:NavigateScreen(dx,dy)
	printf("移动(%d,%d)",dx,dy)
	local randomX=(math.random()*0.6-0.3)*Global.size.width
	local randomY=(math.random()*0.6-0.3)*Global.size.height
	local beginX=randomX+360
	local beginY=randomY+640
	local dis=math.abs(dx)+math.abs(dy)+20
--	for i=1,5 do
--		showRect(beginX-15,beginY-15,beginX+15,beginY+15,500,"0xffff0000")
--		sleep(400)
--	end
	swip(beginX,beginY,beginX-dx,beginY-dy,dis/50)
	showRect(355,635,365,645,500)
end