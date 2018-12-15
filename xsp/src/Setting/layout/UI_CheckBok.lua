--@summary:实现checkbox_kernel
--			table CheckBok:GetSelected():获取当前所有选中的项
--			void AddCheckBox(string id,string caption,string icon=nil):创建新的选择框
--			bool CheckBok.MutiSelect:是否允许多选
UI_CheckBok={}
UI_CheckBok={}
function UI_CheckBok:new(o)
	o = o or {}
	o.view=nil--控件的源视图，来自context:createView()
	o.parent=nil--所属布局
	o.targetX=0
	o.targetY=0
	o.nowX=0
	o.nowY=0

	o.EnableAnimation=false--默认不启用动画
    return setmetatable(o, {__index=UI_CheckBok})
end

--@summary:创建新的控件
--@param string id:对象id
--@param UIContext context:创建控件的布局源
--@param Color3B color:主题色
function UI_CheckBok:Init(id,context,color)
	local ckb=wui.Checkbox.createLayout({
		id=id, 
		title = '', 
		value = 1, 
		hasTopBorder = false, 
		hasBottomBorder = false,
		
	})
	self.id=id
	self.view=context:createView(ckb)
	
end
--@summary:控件点击事件
--@param Action<string,string> callBack:控件被点击后的回调
function UI_CheckBok:OnClick(callBack)
	self.callBack=callBack
    wui.Checkbox.setOnCheckedCallback(self.view, self.callBack)
end
--@summary:控件立即移动到目标点
--@param float newX/newY:控件目标
function UI_CheckBok:Move(newX,newY,applyMove)
	if applyMove then
		self:Navigate(newX,newY)
	end
	self.nowX=newX or self.nowX
	self.nowY =newY or self.nowY
	self.AnimationComplete=false--重置动画
end

--@summary:新增控件目标点
--@param float newX/newY控件新目标
function UI_CheckBok:Navigate(newX,newY)
	self.targetX=newX or self.targetX
	self.targetY=newY or self.targetY
	self.AnimationComplete=false--重置动画
end
--@summary:刷新控件
--@return bool:是否要求布局结束
function UI_CheckBok:Refresh()
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
function UI_CheckBok:Delete()
	self.parent:Delete(self.view:getID())
end

--@summary:设置控件是否被按下
function UI_CheckBok:SetChecked(checked)
	wui.Checkbox.OnChecked(self.id,self.view,self.callback)
end