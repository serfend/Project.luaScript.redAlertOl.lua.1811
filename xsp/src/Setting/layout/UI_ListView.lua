UI_ListView={}
function UI_ListView:new(o)
	o = o or {}
	o.view=nil--控件的源视图，来自context:createView()
	o.parent=nil--所属布局
	o.targetX=0
	o.targetY=0
	o.nowX=0
	o.nowY=0
	o.targetW=0
	o.targetH=0
	o.nowW=0
	o.nowH=0--根据情况，确认需要动画的属性
    return setmetatable(o, {__index=IControl})
end
--@summary:初始化控件
--@param UIContext context:创建控件的布局源
--@param table viewData:控件原始数据
--@param string id:对象id
--@param Color3B color:主题色
function UI_ListView:Init(context,viewData,id,color)
	
end
--@summary:控件点击事件
--@param Action<string,string> callBack:控件被点击后的回调
function UI_ListView:OnClick(callBack)
	local f=function(id,action) callBack(id,action) end
    self.view:setActionCallback(UI.ACTION.CLICK, f)
    self.view:setActionCallback(UI.ACTION.LONG_PRESS, f)
end
--@summary:刷新控件
--@return bool:是否要求布局结束
function UI_ListView:Refresh()
	
	return false
end
--@summary:从布局中删除此控件
function UI_ListView:Delete()
	self.parent:Delete(self.view:getID())
end
