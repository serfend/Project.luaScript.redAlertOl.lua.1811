UI_Button={
	_instanceCount=0
}

--@summary:创建新的按钮
--@param string id:对象id
--@param UIContext context:创建控件的布局源
--@param table rawData:控件原始数据
--@param Color3B color:主题色
function UI_Button:Init(id,context,rawData,color)
	if id then
		rawData.id=id
	else
		UI_Button._instanceCount=UI_Button._instanceCount+1
		rawData.id="btnInner"..UI_Button._instanceCount
	end
	self.view=context:createView(rawData)
	if color then
		View.SetButtonStyle(color,self.view)
	end
end
function UI_Button:new (o)
    o = o or {}
	o.view=nil
	o.targetX=0.0
	o.targetY=0.0
	o.nowX=0.0
	o.nowY=0.0
    return setmetatable(o, {__index=UI_Button})
end

function UI_Button:OnClick(callBack)
	if not callBack then return false end
	local f=function(id,action) callBack(id,action) end
    self.view:setActionCallback(UI.ACTION.CLICK, f)
    self.view:setActionCallback(UI.ACTION.LONG_PRESS, f)
end
--@summary:控件立即移动到目标点
--@param float newX/newY/newW/newH:控件目标
--@param bool applyMove:应用本次移动将使得控件目标点发生变化
function UI_Button:Move(newX,newY,applyMove)
	if applyMove then
		self:Navigate(newX,newY)
	else
		self.AnimationComplete=false--重置动画
	end
	self.nowX=newX or self.nowX
	self.nowY =newY or self.nowY
	
end

--@summary:新增控件目标点
--@param float newX/newY/newW/newH:控件新目标
function UI_Button:Navigate(newX,newY)
	self.targetX=newX or self.targetX
	self.targetY=newY or self.targetY
	self.AnimationComplete=false--重置动画
end
function UI_Button:Refresh()
	if not self.EnableAnimation then 
		return false
	end
	if self.AnimationComplete then
		return false
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
	
	self.view:setStyle({
		left=self.nowX,
		top=self.nowY
	})
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
