--研究所界面下
function CityBuilding:ResearchBegin()
	local anyTask=self:CheckIfAnyResearch()
	if not anyTask then
		self:Research(1)
		sleep(1500)
		self:ResearchAskHelp()
	end
	MainForm:ExitForm(true)
end


function CityBuilding:Research(index)
	if index==1 then
		tap(200,1230)
	else if index==2 then
			tap(550,1230)
		end
	end
	sleep(800)
	tap(500,970)--直接点击右侧按钮提交
	sleep(800)
end
function CityBuilding:CheckIfAnyResearch()
	local point = screen.findColor(Rect(155, 1200, 162, 47), 
"0|0|0x10151b,-58|-5|0x16262f",
95, screen.PRIORITY_DEFAULT)
	return not (point.x>0)
end
function CityBuilding:ResearchAskHelp()
	local point = screen.findColor(Rect(1, 137, 700, 1011), 
"0|0|0xffffff,-11|6|0xffffff,-26|25|0xffffff",
95, screen.PRIORITY_DEFAULT)
	if point.x>0 then
		tap(point.x-30,point.y)
		sleep(1000)
	end
end