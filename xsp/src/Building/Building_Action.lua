function CityBuilding:RunBuilding()

end
local queueButtonY,queueButtonX=182,13
function CityBuilding:SelectConstructQueue(index)
	tap(queueButtonX+30,queueButtonY+30+(index-1)*100)
end

--@summary:建筑升级流程
function CityBuilding:UpLevelBuilding()
	for i=1,2 do
		if self.ConstructQueueFree[i] then
			local queue=Setting.Building.ConstructQueue
			if queue.UseRecommand then
				self:SelectConstructQueue(i)
				sleep(1000)
				if not self:NowSelectBuildingUplevel() then
					self:UpLevelBuildingByPriority()
				end
			else
				self:UpLevelBuildingByPriority()
			end
		end
	end
end

--@summary:升级当前选中的建筑
function CityBuilding:NowSelectBuildingUpLevel()
	local point = screen.findColor(Rect(144, 344, 417, 616), 
"0|0|0x917851,0|42|0xebc889,0|59|0x0f0707,-16|41|0x1e1513,17|41|0x100b0a",
95, screen.PRIORITY_DEFAULT)
	if point.x>0 then
		tap(point.x,point.y+30)
		sleep(1000)
		local r,g,b=screen.getRGB(496,866)--第一个条件的【叉】位置
		if r>220 and g<100 and b<100 then
			ShowInfo.ResInfo("建筑暂不可升级")
			MainForm:ExitForm()
			return false
		end
		tap(524,1117)--立即升级
		sleep(1000)
		tap(354,451)--修复点击后会退出界面，提出【联盟帮助】
	else
		ShowInfo.ResInfo("建筑暂无升级按钮")
		return false
	end
end

--@summary:依据设置的优先级进行升级
function CityBuilding:UpLevelBuildingByPriority()
	
end

function CityBuilding:ReEnterCity()
	tap(65,1233)
	sleep(800)
	ResetForm()
end

function CityBuilding:Navigate(buildingName)
	self:ReEnterCity()
	ShowInfo.ResInfo(string.format("寻找建筑:%s",buildingName))
	sleep(500)
	local targetX,targetY=CityMap[buildingName].x,CityMap[buildingName].y
	self:NavigateScreen(targetX,targetY)
	tap(360,640)
	sleep(1000)
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
	showRect(355,635,365,645,5000)
end