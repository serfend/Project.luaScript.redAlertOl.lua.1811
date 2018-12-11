UI_Layout={

}

--@summary:初始化布局
--@param string contextData:布局数据源
--@param string cssData:布局样式数据源
function UI_Layout:Init(contextData,cssData)
	cssData=cssData or CSS.default
	self.context=UI.createContext(contextData,cssData)
	if not self.context then
		dialog("界面初始化异常，请联系作者\nTrace:"..formatTable(contextData))
		return false
	else
		self.view=self.context:getRootView()
		self:SynView()
	end
end
function UI_Layout.new (o)
    o = o or {}
	o.context=nil
	o.view=nil
	o.Controls={}--管理所有控件
	return setmetatable(o, { __index = UI_Layout })
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
	self:SynView()
end
--@summary:同步当前view尺寸以适应控件变换
function UI_Layout:SynView()
	self.width=self.view:getStyle("width")
	self.height=self.view:getStyle("height")
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
	self.view:addSubview(ui.view)
	ui.parent=self
end

--@summary:清空当前绑定的ui
function UI_Layout:Clear()
	self.Controls={}
end
--@summary:返回当前管理的ui数量
function UI_Layout:Count()
	return #self.Controls
end

function UI_Layout:CreateControl(control)
	
end