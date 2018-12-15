
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
				sleepWithCheckEnemyConquer(1000)
				if not self:NowSelectBuildingUplevel() then
					if self:UpLevelBuildingByPriority() then
						sleepWithCheckEnemyConquer(1000)
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
	self:ResetBuildingNavigator()
	for i=1,7 do
		if buildingInPriority[i] then
			for index,building in ipairs(buildingInPriority[i]) do
				ShowInfo.ResInfo(string.format("%d级:%s 开始",i,building.Description))
				if self:RunBuilding(building.Description) then
					ShowInfo.ResInfo(string.format("%s 完成",building.Description))
					return true
				end
			end
		end
	end
end
function CityBuilding:RunBuilding(buildingName)
	self:Navigate(buildingName,true)
	local success=self:NowSelectBuildingUpLevel()
	return success
end

function CityBuilding:ReEnterCity()
	tap(65,1233)
	sleepWithCheckEnemyConquer(1500)
	ResetForm()
end
local firstTimeFindingBuilding=true
local lastPosX,lastPosY=0,0
--summary:重置建筑导航，将导致寻址时退回重进城市
function CityBuilding:ResetBuildingNavigator()
	firstTimeFindingBuilding=true--归零上次移动
	lastPosX=0
	lastPosY=0
end
function CityBuilding:Navigate(buildingName,relyOnLastBuilding)
	ShowInfo.ResInfo(string.format("寻找建筑:%s",buildingName))
	local building=CityIndex[buildingName]
	if not building then
		dialog(string.format("正在尝试寻找不存在的建筑:%s\n请联系作者询问原因",buildingName))
		return false
	end
	local targetX,targetY=0,0
	if relyOnLastBuilding and (not firstTimeFindingBuilding) then
		print("依据上次坐标进行查询")
		targetX,targetY=building.x-lastPosX,building.y-lastPosY
	else
		self:ReEnterCity()
		firstTimeFindingBuilding=false
		if not self:CheckIfActualyInPoint() then
			ShowInfo.ResInfo("处理总览以修正坐标")
			Building.pandect:NewCheckPandect(true)
			sleep(1000)
			self:ReEnterCity()
		end
		targetX,targetY=building.x,building.y
	end
	lastPosX,lastPosY=building.x,building.y
	
	sleep(500)
	self:NavigateScreen(targetX,targetY)
	if building.isOutside then
		--城外建筑检查是否成功选中，而非点中【获取资源】
		local tryTime=0
		while tryTime<5 do
			tap(360,640)
			sleep(500)
			local point = screen.findColor(Rect(137, 652, 474, 204), 
	"0|0|0xc7a86f,7|-7|0xc1a26b",
	98, screen.PRIORITY_DEFAULT)
			if point.x>0 then break end
			tryTime=tryTime+1
		end
		if tryTime==5 then
			ShowInfo.ResInfo("建筑定位失败")
			self:ResetBuildingNavigator()
			return false
		end
	else
		tap(360,640)
	end
	sleepWithCheckEnemyConquer(1000)
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
--	local randomX=(math.random()*0.2-0.1)*Global.size.width
--	local randomY=(math.random()*0.2-0.1)*Global.size.height
	local beginX=360
	local beginY=640
	local dis=math.abs(dx)+math.abs(dy)+20

	swip(beginX,beginY,beginX-dx,beginY-dy,dis/50)
	showRectPos(360,640,500)
end