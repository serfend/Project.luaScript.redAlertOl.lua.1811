
function UIHandle:Dialog_NewVersion(title,info,callbackOk,callbackCancel)
	local layout=UI_Layout:new()
	layout:Init(Context.retDialog)
	local dialogHeight=400
	local dialogWidht=Global.size.width*0.8
	layout:SetStyle(View.SetLayoutCenter(dialogWidht,dialogHeight))
	
	local timespan=UI_Timespan:new()
	timespan:Init("countdown_1",layout.context,Context.TimeSpan,Color3B(100,100,200),dialogWidht,10)
	
	local TxtTitle=UI_Label:new()
	TxtTitle:Init("TxtTitle",layout.context,Context.LabelNormal,Color3B(100,100,220))
	TxtTitle:SetText(title)
	TxtTitle:SetFontSize(20)
	
	local TxtInfo=UI_Label:new()
	TxtInfo:Init("TxtInfo",layout.context,Context.LabelNormal,Color3B(100,100,220))
	TxtInfo:SetText(info)
	TxtInfo:SetFontSize(20)
	
	local BtnOk=UI_Button:new()
	BtnOk:Init("BtnOk",layout.context,Context.BtnNormal,Color3B(100,100,200))
	BtnOk:SetText("确定")
	BtnOk:OnClick(
		function(id,action)
			callbackOk()
		end
	)
	
	local BtnCancel=UI_Button:new()
	BtnCancel:Init("BtnCancel",layout.context,Context.BtnNormal,Color3B(200,100,100))
	BtnCancel:SetText("取消")
	BtnCancel:OnClick(
		function(id,action)
			callbackCancel()
		end
	)
	
	layout:Add(timespan)
	layout:Add(TxtTitle)
	layout:Add(TxtInfo)
	layout:Add(BtnOk)
	layout:Add(BtnCancel)
	
	layout:Show()
	while self.anyUIShow do
		sleep(10)
		if layout:Refresh() then
			self:CloseContext()
		end
	end
	layout:Close()
end