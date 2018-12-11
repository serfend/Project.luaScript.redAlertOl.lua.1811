--@summary:设置的主界面
function UIHandle:SettingDialogShow(callBackOk,callBackCancel)
	local uilist=Container:new()
	uilist:Add("layout",UI_Layout:new())
	uilist.layout:Init(Context.rootSetting)
	local dialogHeight=math.floor(Global.size.height)
	local dialogWidth=math.floor(Global.size.width)
	uilist.layout:SetStyle(View.SetLayoutCenter(dialogWidth,dialogHeight))
	
	self:BuildConfirmButton(uilist,callBackOk,callBackCancel)
	self:BuildMenu(uilist)
	
	self:ControlsBind(uilist)
	self:Dialog_Show(uilist)
	
end

function UIHandle:BuildConfirmButton(uilist,callBackOk,callBackCancel)
	local btnOK=self:BuildButton(uilist,callBackOk,Color3B(200,200,255),"运行")
	btnOK.EnableAnimation=true
	local btnTop=uilist.layout.view:getStyle("height")-btnOK.view:getStyle("height")
	btnOK:Navigate(nil,btnTop)
	btnOK.view:setStyle("width",375)
	btnOK.view:setStyle("position","absolute")
	
	local btnCancel=self:BuildButton(uilist,callBackCancel,Color3B(255,100,100),"设置组...")
	btnCancel:Move(375)
	btnCancel:Navigate(375,btnTop)
	btnCancel.EnableAnimation=true
	btnCancel.view:setStyle("width",375)
	btnCancel.view:setStyle("position","absolute")

end
function UIHandle:BuildMenu(uilist)
	uilist:Add("tab",UI_Tab:new())
	uilist.tab:Init("mainTab",uilist.layout.context,Context.MainSetting,{
		currentPage=1,
		pageWidth=700,
		pageHeight=1000,
		tabTitles=Context.MainSettingTitle,
	},function(id,pageIndex) 
		
	end)
	uilist.tab.view:setStyle({
		top=100,
		left=25
	})
end