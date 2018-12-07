
function UIHandle:Dialog_OkCancel(title,info,callbackOk,callbackCancel)
	local uilist={}
	uilist.layout=UI_Layout:new()
	uilist.layout:Init(Context.retDialog)
	local dialogHeight=400
	local dialogWidht=Global.size.width*0.8
	uilist.layout:SetStyle(View.SetLayoutCenter(dialogWidht,dialogHeight))
	
	uilist.timespan=UI_Timespan:new()
	uilist.timespan:Init("countdown_1",uilist.layout.context,Context.TimeSpan,Color3B(100,100,200),dialogWidht,15)
	
	uilist.TxtTitle=UI_Label:new()
	uilist.TxtTitle:Init("TxtTitle",uilist.layout.context,Context.LabelNormal,Color3B(100,100,220))
	uilist.TxtTitle:SetText(title)
	uilist.TxtTitle:SetFontSize(40)
	uilist.TxtTitle.nowX=-dialogWidht
	
	uilist.TxtInfo=UI_Label:new()
	uilist.TxtInfo:Init("TxtInfo",uilist.layout.context,Context.LabelNormal,Color3B(100,100,220))
	uilist.TxtInfo:SetText(info)
	uilist.TxtInfo:SetFontSize(20)
	uilist.TxtInfo.nowX=dialogWidht

	local btnOK=self:BuildButton(uilist,callbackOk,Color3B(100,100,220),"确定")
	local btnCancel=self:BuildButton(uilist,callbackCancel,Color3B(200,100,100),"取消")
	
	btnOK.nowY=dialogHeight
	btnCancel.nowY=dialogHeight

	self:ControlsBind(uilist)
	self:Dialog_Show(uilist)
end