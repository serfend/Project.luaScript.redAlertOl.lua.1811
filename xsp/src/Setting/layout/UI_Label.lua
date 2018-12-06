UI_Label={
	view=nil,
	targetX=0,targetY=0,
	nowX=0,nowY=0
}

--@summary:创建新的标签
--@param string id:对象id
--@param UIContext context:创建控件的布局源
--@param table rawData:控件原始数据
--@param Color3B color:主题色
function UI_Label:Init(id,context,rawData,color)
	rawData.id=id
	self.view=context:createView(rawData)
end
function UI_Label:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
	return o
end
function UI_Label:OnClick(callBack)
	local f=function(id,action) 
		callBack(id,action)
		self.targetY=self.targetY+10
	end
    self.view:setActionCallback(UI.ACTION.CLICK, f)
    self.view:setActionCallback(UI.ACTION.LONG_PRESS, f)
end

function UI_Label:Refresh()
	if math.abs(self.nowX-self.targetY)+math.abs(self.nowY-self.targetY)>1 then
		self.nowX=self.nowX*0.9+self.targetX*0.1
		self.nowY=self.nowY*0.9+self.targetY*0.1
		self.view:setStyle({
			left=self.nowX,
			top=self.nowY
		})
	end
end

--@summary:从布局中删除此控件
function UI_Label:Delete()
	self.parent:Delete(self.view:getID())
end



function UI_Label:SetFontSize(size)
	self.view:setStyle("font-size",size)
end
function UI_Label:SetText(text)
	self.view:setAttr("value",text)
end