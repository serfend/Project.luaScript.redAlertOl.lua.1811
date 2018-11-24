Form = {
	nowState=0,
}--初始化
function Form:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function Form:CheckIfAnyDialog()
	local point = screen.findColor(Rect(630, 359, 59, 66), 
"0|0|0xffbcad,-8|6|0xf3aa9d,-21|6|0x5e120f",
95, screen.PRIORITY_DEFAULT)
	return point.x>0,point
end
function Form:ConfirmForm_OK()
	local point = screen.findColor(Rect(254, 798, 213, 106), 
"0|0|0x7f461e,0|46|0xd99d39",
95, screen.PRIORITY_DEFAULT)
	if point.x>0 then
		tap(point.x,point.y)
		return true
	else
		return false
	end
end
function Form:ConfirmForm_OKCancel(frmConfirm)
	dialog("ConfirmForm_OKCancel()no  implement")
end

function Form:ReturnBase()--以点击左下角出城回城的方式返回主基地
	
end





function Form:CheckNormalPageTask()
	Form:CheckPartyAssistance()
end
function Form:CheckPartyAssistance()
	point = screen.findColor(Rect(616, 931, 83, 97), 
"0|0|0xecf1fb,26|-14|0xff0000,-23|0|0xf2f4fb,6|10|0xdae6fa",
95, screen.PRIORITY_DEFAULT)
	if point.x>0 then
		tap(point.x,point.y)
		ShowInfo.RunningInfo("<联盟帮助>")
	end
end