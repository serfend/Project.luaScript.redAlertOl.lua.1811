--@summary:设置的主界面
function UIHandle:SettingDialogShow()
	local uilist=Container:new()
	uilist:Add("layout",UI_Layout:new())
	uilist.layout:Init(Context.rootSetting)
	local dialogHeight=math.floor(Global.size.height*0.7)
	local dialogWidth=math.floor(Global.size.width)
	uilist.layout:SetStyle(View.SetLayoutCenter(dialogWidth,dialogHeight))
	

	uilist:Add("TxtTitle",UI_Label:new())
	uilist.TxtTitle:Init("TxtTitle",uilist.layout.context,Context.LabelNormal,Color3B(100,100,220))
	uilist.TxtTitle:SetText("界面初始化")
	uilist.TxtTitle:SetFontSize(40)
	uilist.TxtTitle.nowX=-dialogWidth
	

	local btnOK=self:BuildButton(uilist,callbackOk,Color3B(200,200,255),"运行")
	btnOK.targetY=uilist.layout.view:getStyle("height")-btnOK.view:getStyle("height")
	btnOK.view:setStyle("width",dialogWidth*0.5)
	btnOK.view:setStyle("position","absolute")
	
	local btnCancel=self:BuildButton(uilist,callBackCancel,Color3B(255,100,100),"设置组...")
	btnCancel.nowX=dialogWidth*0.5
	btnCancel.targetY=uilist.layout.view:getStyle("height")-btnCancel.view:getStyle("height")
	btnCancel.targetX=dialogWidth*0.5
	btnCancel.view:setStyle("width",dialogWidth*0.5)
	btnCancel.view:setStyle("position","absolute")

	self:ControlsBind(uilist)
	self:Dialog_Show(uilist)
end