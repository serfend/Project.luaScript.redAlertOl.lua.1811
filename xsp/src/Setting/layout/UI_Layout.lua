UI_Layout={
	context=nil,
	rootView=nil,
	Controls={},--管理所有控件
}

--@summary:初始化布局
--@param string contextData:布局数据源
--@param string cssData:布局样式数据源
function UI_Layout:Init(contextData,cssData)
	cssData=cssData or CSS.default
	self.context=UI.createContext(contextData,CSS.default)
	self.rootView=self.context:getRootView()
end
function UI_Layout:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
	return o
end
function UI_Layout:Show()
	self.context:show()
end
function UI_Layout:Close()
	self.context:close()
end
--@summary:设置布局样式
--@param table styleTable:样式数据
function UI_Layout:SetStyle(styleTable)
	self.context:getRootView():setStyle(styleTable)
end
function UI_Layout:Refresh()
	for i,k in ipairs(self.Controls) do
		if k:Refresh() then
			return true--任何一个控件要求结束
		end
	end
	return false
end

--@summary:删除控件
--@param string id:需要删除的控件id
function UI_Layout:Delete(id)
	for i,k in ipairs(self.Controls) do
		if k.view:getId()==id then
			self.context:removeSubview(i)
			table.remove(self.Controls,i)
			return true
		end
	end
	return false
end

--@summary:在此布局下加入控件
function UI_Layout:Add(ui)
	table.insert(self.Controls,ui)
	self.rootView:addSubview(ui.view)
	ui.parent=self
end