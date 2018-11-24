function pandect:DoResearch(targetPos,param)
	ShowInfo.RunningInfo("<研究所>")
	if param==1 then
		tap(targetPos.x,targetPos.y)
	else if param==2 then
			tap(targetPos.x,targetPos.y)
			sleep(1000)
			Building.building:ResearchBegin()
		end
	end
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
		self:DoResearch(self:PanelPos(1,1),result)
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
function pandect:DoTreat(targetPos,param)
	ShowInfo.RunningInfo("<维修部队>")
	if param==2 then
		tap(targetPos.x,targetPos.y)--仅收取
		sleep(1000)
	else 
		if param==0 then
			tap(targetPos.x,targetPos.y)
			sleep(500)
			tap(554,1208)--修复按钮所在位置
			sleep(500)
			--self:Enter()--修复后会导致界面被关闭
		end
	end
end