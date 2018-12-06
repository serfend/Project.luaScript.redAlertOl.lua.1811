UI_Button={
	view=nil,
}

--@summary:创建新的按钮
--@param string id:对象id
--@param UIContext context:创建控件的布局源
--@param table rawData:控件原始数据
--@param Color3B color:主题色
function UI_Button:Init(id,context,rawData,color)
	rawData.id=id
	self.view=context:createView(rawData)
	View.SetButtonStyle(color,self.view)
end
function UI_Button:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
	return o
end

function UI_Button:OnClick(callBack)
	local f=function(id,action) callBack(id,action) end
    self.view:setActionCallback(UI.ACTION.CLICK, f)
    self.view:setActionCallback(UI.ACTION.LONG_PRESS, f)
end
--@summary:刷新控件
--@return bool:是否要求布局结束
function UI_Button:Refresh()
	
	return false
end
--@summary:从布局中删除此控件
function UI_Button:Delete()
	self.parent:Delete(self.view:getID())
end

function UI_Button:SetText(text)
	if not text then return end
	self.view:getSubview(1):setAttr("value",text)
end
