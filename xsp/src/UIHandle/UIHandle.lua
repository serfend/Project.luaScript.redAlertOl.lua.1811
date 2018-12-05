UIHandle={
	anyUIShow=false,--当有任何UI运行时,停止操作
	uiDialog="",
	uiInfo="",
}
require "UIHandle.UIHandle_Action"
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
	if self.anyDialog then
		self.anyDialog=false
		self.anyUIShow=true
		ShowInfo.RunningInfo("NewDialog")
	else
		return
	end
	if self.uiDialog=="newVersion" then
		return self:Dialog_NewVersion()
	end
end
