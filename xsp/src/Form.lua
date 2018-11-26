Form = {
	nowState=0,lastScene=0
}--初始化
function Form:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function Form:CheckIfRewardDialog()
	local point = screen.findColor(Rect(630, 359, 59, 66), 
"0|0|0xffbcad,-8|6|0xf3aa9d,-21|6|0x5e120f",
95, screen.PRIORITY_DEFAULT)
	return point.x>0,point
end
function Form:CheckIfProductDialog()
	
end
--@summary:以点击左下角出城回城的方式返回主基地
function Form:ReturnBase()
	tap(38,452)
	sleep(500)
	tap(65,1233)
	sleep(500)
end
function Form:ExitForm(exitAll)
	local nowScene=toolBar:GetNowScene()
	if nowScene==3 then
		tap(20,80)--左上角就是退出按钮
		sleep(500)
		if exitAll then self:ExitForm(exitAll) end
	end
end

function Form:CheckNormalPageTask()
	self:CheckPartyAssistance()
	local nowScene=toolBar:GetNowScene()
	if nowScene==1 then
		normal:CheckAnyFreeBuilding() 
	end
	if lastScene~=nowScene then--场景发生变化，则说明用户进行了操作，取消主动操作
		Setting.Runtime.ActiveMode.LastActiveTime=os.milliTime()
		lastScene=nowScene
	end
end
function Form:CheckPartyAssistance()
	local point = screen.findColor(Rect(666, 931, 46, 49), 
"0|0|0xfd0000,18|0|0xfd0000",
95, screen.PRIORITY_DEFAULT)
	if point.x>0 then
		tap(656,978)
		ShowInfo.RunningInfo("<联盟帮助>")
	end
end