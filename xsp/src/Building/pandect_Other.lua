function pandect:CheckIfResearch()
	
end

function pandect:GetSupply(targetPos)
	ShowInfo.RunningInfo("获取空投补给")
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
	local point = screen.findColor(Rect(525, 458, 166, 38), 
"0|0|0xe26f30,-30|-2|0xbd4929,-101|-4|0xbb4928",
95, screen.PRIORITY_DEFAULT)
	if point.x>0 then
		result=0
	else
		point = screen.findColor(Rect(525, 458, 166, 38), 
"0|0|0x45b538,-10|0|0x44b436,-100|-3|0x40b235",
95, screen.PRIORITY_DEFAULT)
		if point.x>0 then
			result=2
		else
			return false
		end
	end
	return function() 
		self:DoTreat(point,result)
	end
end
function pandect:DoTreat(targetPos,param)
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