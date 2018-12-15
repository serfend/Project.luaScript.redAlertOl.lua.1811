--@summary:用于静态创建的通用控件容器
UI_Div={
	_instanceCount=0
}

--@summary:创建新的标签
--@param UIContext context:创建控件的布局源
--@param table rawData:控件原始数据
--@param Color3B color:主题色
function UI_Div:Init(context,rawData,color)
	UI_Div._instanceCount=UI_Div._instanceCount+1
	rawData.id="UIDiv_"..UI_Div._instanceCount
	self.view=context:createView(rawData)
end
function UI_Div:new (o)
    o = o or {}
	o.view=nil
    setmetatable(o, {__index=UI_Div})
    return o
end
--@summary:从布局中删除此控件
function UI_Div:Delete()
	self.parent:Delete(self.view:getID())
end