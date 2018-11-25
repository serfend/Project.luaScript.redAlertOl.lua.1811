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
--@summary:检查菜单栏是否有新的消息
--@param index:菜单按钮的序号
--@return:返回此按钮是否有红点
function ToolBar:CheckIfHaveMsg(index)

end