--研究所界面下
function building:ResearchBegin()
	local anyTask=self:CheckIfAnyResearch()
	if not anyTask then
		self:Research(1)
		sleep(1500)
		self:ResearchAskHelp()
	end
	MainForm:ExitForm(true)
end


function building:Research(index)
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
function building:CheckIfAnyResearch()
	local point = screen.findColor(Rect(155, 1200, 162, 47), 
"0|0|0x10151b,-58|-5|0x16262f",
95, screen.PRIORITY_DEFAULT)
	return not (point.x>0)
end
function building:ResearchAskHelp()
	local point = screen.findColor(Rect(44, 137, 662, 1011), 
"0|0|0xffffff,-11|6|0xffffff,-26|25|0xffffff",
95, screen.PRIORITY_DEFAULT)
	if point.x>0 then
		tap(point.x-30,point.y)
		sleep(1000)
	end
end