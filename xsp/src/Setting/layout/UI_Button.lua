UI_Button={
	view=nil,
}

--@summary:创建新的按钮
--@param UIContext context:创建控件的布局源
--@param table viewData:控件原始数据
--@param string id:对象id
--@param Color3B color:主题色
function UI_Button:Init(context,viewData,id,color)
	viewData.id=id
	self.view=context:createView(viewData)
	View.SetButtonStyle(color,self.view)
end
function UI_Button:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
	return o
end

function UI_Button:OnClick(callBack)
    local onClicked = function (id, action)
        callback(id, action)
    end
    self.view:setActionCallback(UI.ACTION.CLICK, onClicked)
    self.view:setActionCallback(UI.ACTION.LONG_PRESS, onClicked)
end
function UI_Button:SetText(text)
	self.view:getSubview(1):setAttr("value",text)
end
--@summary:从此对象父对象中删除此对象
function UI_Button:Delete()
	
end