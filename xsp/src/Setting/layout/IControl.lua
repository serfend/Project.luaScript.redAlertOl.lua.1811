IControl={
	view=nil,--控件的源视图，来自context:createView()
	parent=nil,--所属布局
}
function IControl:new(o)
	o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
--@summary:初始化控件
--@param UIContext context:创建控件的布局源
--@param table viewData:控件原始数据
--@param string id:对象id
--@param Color3B color:主题色
function IControl:Init(context,viewData,id,color)
	
end
--@summary:控件点击事件
--@param Action<string,string> callBack:控件被点击后的回调
function IControl:OnClick(callBack)
	local f=function(id,action) callBack(id,action) end
    self.view:setActionCallback(UI.ACTION.CLICK, f)
    self.view:setActionCallback(UI.ACTION.LONG_PRESS, f)
end
--@summary:刷新控件
--@return bool:是否要求布局结束
function IControl:Refresh()
	
	return false
end
--@summary:从布局中删除此控件
function IControl:Delete()
	self.parent:Delete(self.view:getID())
end
