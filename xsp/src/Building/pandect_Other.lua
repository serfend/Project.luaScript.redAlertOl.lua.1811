function pandect:DoResearch(targetPos,param)
	ShowInfo.RunningInfo("<研究所>")
	if param==1 then
		tap(targetPos.x,targetPos.y)
		sleep(1500)
		self:EnterNextResearch(targetPos)
	else if param==2 then
			self:EnterNextResearch(targetPos)
		else
			return false
		end
	end
	return true
end
function pandect:EnterNextResearch(targetPos)
	ShowInfo.ResInfo("开始下一个研究")
	tap(targetPos.x,targetPos.y)
	sleep(1000)
	Building.building:ResearchBegin()
end
--1:可直接领取 2:需要研究
function pandect:CheckIfResearch()
	local result=0
	if self:PanelIsGreen(1,1) then
		result=1
	else
		if self:PanelIsBlue(1,1) then
			result=2
		else
			return false
		end
	end
	return function()
		return self:DoResearch(self:PanelPos(1,1),result)
	end
end

function pandect:GetSupply(targetPos)
	ShowInfo.RunningInfo("<空投补给>")
	tap(targetPos.x,targetPos.y)
	sleep(500)
	tap(360,830)
	sleep(500)
end
function pandect:CheckIfSupply()
	local point = screen.findColor(Rect(366, 539, 66, 69), 
"0|0|0xfbf1df,2|9|0xffd422,-13|6|0xedc950",
95, screen.PRIORITY_DEFAULT)
	if point.x>0 then
		return function()
			self:GetSupply(point)
		end
	else
		return false
	end
end

-- -1:无 0:需要治疗 1:等待治疗 2:可收取
function pandect:CheckIfTreat()
	local result=0
	if self:PanelIsOrange(2,1) then
		result=0
	else
		if self:PanelIsGreen(2,1) then
			result=2
		else
			return false
		end
	end
	return function() 
		self:DoTreat(self:PanelPos(2,1),result)
	end
end
--@summary:注意维修中也会出现【可维修】
--
function pandect:DoTreat(targetPos,param)
	ShowInfo.RunningInfo("<维修部队>")
	if param==2 then
		tap(targetPos.x,targetPos.y)--仅收取
		sleep(1000)
	else 
		if param==0 then
			tap(targetPos.x,targetPos.y)
			sleep(1000)
			if self:CheckIfRepairing() then
				MainForm:ExitForm()
			else
				tap(554,1208)--修复按钮所在位置
				sleep(1500)
				tap(354,451)--修复点击后会退出界面，提出【联盟帮助】
			end
		end
	end
end
function pandect:CheckIfRepairing()
	local point = screen.findColor(Rect(673, 1050, 28, 17), 
"0|0|0x325995,12|1|0x151515",
95, screen.PRIORITY_DEFAULT)
	return point.x>0
end