UIHandle={
	anyUIShow=false,--当有任何UI运行时,停止操作
	uiDialog="",
	uiInfo="",
	InitCheck=false,--当有第一条消息到达后返回
}
require "UIHandle.UIHandle_Dialog"
function UIHandle:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function UIHandle:NewDialog(id,info)
	self.uiDialog=id
	self.uiInfo=info
	self.anyDialog=true
end
function UIHandle:CheckIfNewDialog()
	if self.anyUIShow then
		return true--当已有ui正在显示时
	end
	if self.anyDialog then
		self.anyDialog=false
		self.anyUIShow=true
		ShowInfo.RunningInfo(string.format("::%s",self.uiDialog))
	else
		return false
	end
	if self.uiDialog=="newVersion" then
		local verInfo=string.GetElementInItem(self.uiInfo,"newVersion")
		local ver=string.GetElementInItem(verInfo,"ver")
		local des=string.GetElementInItem(verInfo,"des")
		return self:Dialog_NewVersion("新版本"..ver,des,
			function(x) self:CloseContext(x) end,
			function(x) self:CloseContext(x) end
		)
	end
end


function UIHandle:CloseContext()
	self.anyUIShow=false
end