
function UIHandle:Dialog_NewVersion()
	local verInfo=string.GetElementInItem(self.uiInfo,"newVersion")
	local ver=string.GetElementInItem(verInfo,"ver")
	local des=string.GetElementInItem(verInfo,"des")
	local context=UI.createContext(Context.retDialog,CSS.default)
	local rootView=context:getRootView()
	local dialogHeight=400
	local dialogWidht=Global.size.width*0.8
	rootView:setStyle(View.SetLayoutCenter(dialogWidht,dialogHeight))
	
	local timespan=UI_Timespan:new()
	timespan:Init("countdown_1",context,Context.TimeSpan,dialogWidht,10)
	rootView:addSubview(timespan.view)
	
	local BtnOkView=UI_Button:new()
	BtnOkView:Init(context,Context.BtnNormal,"BtnOk",Color3B(100,100,200))
	BtnOkView:OnClick(
		function(id,action)
			
		end
	)
	BtnOkView:SetText("确定")
	rootView:addSubview(BtnOkView.view)
	
	local BtnCancel=UI_Button:new()
	BtnCancel:Init(context,Context.BtnNormal,"BtnCancel",Color3B(200,100,100))
	BtnCancel:SetText("取消")
	rootView:addSubview(BtnCancel.view)
	context:show()
	while self.anyUIShow do
		sleep(10)
		if timespan:Refresh() then
			self.anyUIShow=false
			context:close()
		end
	end
	
end