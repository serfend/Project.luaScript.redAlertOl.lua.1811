
function UIHandle:Dialog_OkCancel(title,info,callbackOk,callbackCancel)
	local uilist=Container:new()
	uilist:Add("layout",UI_Layout:new())
	uilist.layout:Init(Context.retDialog)
	local dialogHeight=400
	local dialogWidth=Global.size.width*0.9
	uilist.layout:SetStyle(View.SetLayoutCenter(dialogWidth,dialogHeight))
	
	uilist:Add("timespan",UI_Timespan:new())
	uilist.timespan:Init("countdown_1",uilist.layout.context,Context.TimeSpan,Color3B(100,100,200),dialogWidth,15)
	
	uilist:Add("TxtTitle",UI_Label:new())
	uilist.TxtTitle:Init("TxtTitle",uilist.layout.context,Context.LabelNormal,Color3B(100,100,220))
	uilist.TxtTitle:SetText(title)
	uilist.TxtTitle:SetFontSize(40)
	uilist.TxtTitle.EnableAnimation=true
	uilist.TxtTitle:Move(-750)


	uilist:Add("TxtInfo",UI_Label:new())
	uilist.TxtInfo:Init("TxtInfo",uilist.layout.context,Context.LabelNormal,Color3B(100,100,220))
	uilist.TxtInfo:SetText(info)
	uilist.TxtInfo:SetFontSize(20)
	uilist.TxtInfo.EnableAnimation=true
	uilist.TxtInfo:Move(750)

	local btnOK=self:BuildButton(uilist,callbackOk,Color3B(100,100,220),"确定")
	local btnCancel=self:BuildButton(uilist,callbackCancel,Color3B(200,100,100),"取消")
	
	btnOK:Move(nil,dialogHeight)
	btnCancel:Move(nil,dialogHeight)
	btnOK.EnableAnimation=true
	btnCancel.EnableAnimation=true
	self:ControlsBind(uilist)
	self:Dialog_Show(uilist)
end