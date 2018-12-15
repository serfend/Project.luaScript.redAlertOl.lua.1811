UI_TextBox={}


--@summary:创建新的输入框
--@param string id:对象id
--@param UIContext context:创建控件的布局源
--@param table rawData:控件原始数据
--@param Color3B color:主题色
function UI_TextBox:Init(id,context,rawData,color)
	rawData.id=id
	self.view=context:createView(rawData)
end
function UI_TextBox:new (o)
    o = o or {}
	o.view=nil
	o.targetX=0
	o.targetY=0
	o.nowX=0
	o.nowY=0
	o.EnableAnimation=false
    setmetatable(o, {__index=UI_Label})
    return o
end

--@summary:控件立即移动到目标点
--@param float newX/newY:控件目标
--@param bool applyMove:应用本次移动将使得控件目标点发生变化
function UI_TextBox:Move(newX,newYapplyMove)
	if applyMove then
		self:Navigate(newX,newY)
	end
	self.nowX=newX or self.nowX
	self.nowY =newY or self.nowY
	self.AnimationComplete=false--重置动画
end

--@summary:新增控件目标点
--@param float newX/newY:控件新目标
function UI_TextBox:Navigate(newX,newY)
	self.targetX=newX or self.targetX
	self.targetY=newY or self.targetY
	self.AnimationComplete=false--重置动画
end
function UI_TextBox:Refresh()
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
function UI_TextBox:Delete()
	self.parent:Delete(self.view:getID())
end



function UI_TextBox:SetFontSize(size)
	self.view:setStyle("font-size",size)
end
function UI_TextBox:SetText(text)
	self.view:setAttr("value",text)
end