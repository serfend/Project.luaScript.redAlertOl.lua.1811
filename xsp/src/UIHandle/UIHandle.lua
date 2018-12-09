UIHandle={

}
require "UIHandle.UIHandle_Dialog"
require "UIHandle.UIHandle_Manager"
require "UIHandle.UIHandle_Setting"
function UIHandle:new(o)
    o = o or {}
	o.anyUIShow=false--当有任何UI运行时,停止操作
	o.uiDialog=""
	o.uiInfo=""
	o.uiResult=""
	o.InitCheck=false--当有第一条消息到达后返回
    return setmetatable(o, {__index=UIHandle})
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
		return self:Dialog_OkCancel("新版本"..ver,des,
			function(x) 
				self.uiResult="ok"
				self:CloseContext()
			end,
			function(x) 
				self.uiResult="cancel"
				self:CloseContext()
			end
		)
	end
	if self.uiDialog=="normalDialogOkCancel" then
		local title=string.GetElementInItem(self.uiInfo,"title")
		local info=string.GetElementInItem(self.uiInfo,"info")
		return self:Dialog_OkCancel(title,info,
			function(x)
				self.uiResult="ok"
				self:CloseContext()
			end,
			function(x)
				self.uiResult="cancel"
				self:CloseContext()
			end
		)
	end
	if self.uiDialog=="mainSetting" then--主设置界面
		return self:SettingDialogShow()
	end
end
function UIHandle:CloseContext()
	self.anyUIShow=false
end