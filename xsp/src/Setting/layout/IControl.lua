IControl={}
function IControl:new(o)
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
	o.EnableAnimation=false--默认不启用动画
    return setmetatable(o, {__index=IControl})
end

--@summary:创建新的控件
--@param string id:对象id
--@param UIContext context:创建控件的布局源
--@param table rawData:控件原始数据
--@param Color3B color:主题色
function IControl:Init(id,context,rawData,color)
	
end
--@summary:控件点击事件
--@param Action<string,string> callBack:控件被点击后的回调
function IControl:OnClick(callBack)
	local f=function(id,action) callBack(id,action) end
    self.view:setActionCallback(UI.ACTION.CLICK, f)
    self.view:setActionCallback(UI.ACTION.LONG_PRESS, f)
end
--@summary:控件立即移动到目标点
--@param float newX/newY/newW/newH:控件目标
function IControl:Move(newX,newY,newW,newH,applyMove)
	if applyMove then
		self:Navigate(newX,newY,newW,newH)
	end
	self.nowX=newX or self.nowX
	self.nowY =newY or self.nowY
	self.nowW=newW or self.nowW
	self.nowH=newH or self.nowH
	self.AnimationComplete=false--重置动画
end

--@summary:新增控件目标点
--@param float newX/newY/newW/newH:控件新目标
function IControl:Navigate(newX,newY,newW,newH)
	self.targetX=newX or self.targetX
	self.targetY=newY or self.targetY
	self.targetW=newW or self.targetW
	self.targetH=newH or self.targetH
	self.AnimationComplete=false--重置动画
end
--@summary:刷新控件
--@return bool:是否要求布局结束
function IControl:Refresh()
	if not self.EnableAnimation then 
		return false
	end
	if self.AnimationComplete then
		return true
	end
	local newMoveCheck= math.abs(self.nowX-self.targetX)+math.abs(self.nowY-self.targetY)>10
	if newMoveCheck then
		self.nowX=self.nowX*0.8+self.targetX*0.2
		self.nowY=self.nowY*0.8+self.targetY*0.2
	else
		self.nowX=self.targetX
		self.nowY=self.targetY
		self.AnimationComplete=true
	end
	if self.nowX>self.parent.width then 
		self.AnimationComplete=true
	end
	if self.nowY>self.parent.height then 
		self.AnimationComplete=true
	end
	self.view:setStyle({
		left=self.nowX,
		top=self.nowY
	})
	return false
end
--@summary:从布局中删除此控件
function IControl:Delete()
	self.parent:Delete(self.view:getID())
end
