ToolBar = {
	nowScene=0,
	userEnergy=0,
}--初始化
function ToolBar:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function ToolBar:SynUserEnergy()
	
end
function ToolBar:CheckIfInCity()
	--showRect(555,52,555+81,52+47,5000)
	local point = screen.findColor(Rect(555, 52, 81, 47), 
"0|0|0x773e11,1|35|0xc67f39",
95, screen.PRIORITY_DEFAULT)
	return point.x>0
end
function ToolBar:CheckIfInWorld()
	local point = screen.findColor(Rect(551, 56, 105, 45), 
"0|0|0x0e3331,0|33|0x1f8d8e",
95, screen.PRIORITY_DEFAULT)
	return point.x>0 
end
--@summary:获取当前场景
--@return:0-未知 1-城市 2-世界
function ToolBar:GetNowScene()
	screen:keep(true)
	if self:CheckIfInCity() then
		self.nowScene=1
	else
		if self:CheckIfInWorld() then
			self.nowScene=2
		else
			self.nowScene=3
		end
	end
	screen.keep(false)
	ShowInfo.ResInfo(string.format("当前处于%s场景下",Const.Toolbar.scene[self.nowScene]))
	return self.nowScene
end
local toolBarInfo={
	toolBar={
		[1]={206,1172,42,45},
		[2]={328,1173,44,49},
		[3]={443,1174,46,45},
		[4]={557,1176,47,46},
		[5]={677,1174,43,46},
	}
}
--@summary:检查菜单栏是否有新的消息
--@param index:菜单按钮的序号
--@return:返回此按钮是否有红点
function ToolBar:CheckIfHaveMsg(index)
	return self:CheckNowPageMsg(Rect(
		toolBarInfo.toolBar[index][1],
		toolBarInfo.toolBar[index][2],
		toolBarInfo.toolBar[index][3],
		toolBarInfo.toolBar[index][4]))
end

function ToolBar:CheckNowPageMsg(rect)
	return screen.findColor(rect, 
"0|0|0xba0012,0|28|0xe10008,-13|15|0xeb0005,13|15|0xf40003",
95, screen.PRIORITY_LEFT_FIRST)
end