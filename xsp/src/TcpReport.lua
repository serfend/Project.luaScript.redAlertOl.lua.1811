function msgCallBack(msg)
	print("来自服务器:"..msg)
	if string.contains(msg,"<SetSetting>") then
		local list=string.GetAllElement(msg,"<setting>","</setting>")
		for i,v in ipairs(list) do
			local key=string.GetElementInItem(v,"key")
			local value=string.GetElementInItem(v,"value")
			local tmp=split(key,".")--设置.子设置.子子设置
			local rawSet=Setting
			for j=1,#tmp-1 do
				rawSet=rawSet[v2]
			end
			local checkNumber=tonumber(tmp[#tmp])--判断最后一项是否为数字
			if checkNumber then
				rawSet[checkNumber]=value
			else
				rawSet[tmp[#tmp]]=value
			end
		end
	end
	if string.contains(msg,"<GetAllSetting>") then
		connection:send("AllSetting",formatTable(Setting))
	end
	if string.contains(msg,"<ClientInit>") then
		local clientName=storage.get("client.Name","null")
		local clientId=app:DeviceID()
		local userInfo, code = script.getUserInfo()
		
		if code==-1 then
			userInfo={id="developeMode",membership=0,expiredTime=0}
		else if code==0  then
			
			else
				userInfo={id="exception()"..code,membership=0,expiredTime=0}
			end
		end
		connection:send("ScriptClientInit",string.format(
			"<ver>%s</ver><Name>%s</Name><ID>%s</ID><User>%s</User><member>%s</member><time>%s</time>",
			app.Version,clientName,clientId,userInfo.id,userInfo.membership,userInfo.expiredTime
		))
	end
	if string.contains(msg,"<setName>") then
		local newName=string.GetElementInItem(msg,"setName")
		storage.put("client.Name",newName)
	end
	if string.contains(msg,"<newVersion>") then
		local verInfo=string.GetElementInItem(msg,"newVersion")
		local ver=string.GetElementInItem(verInfo,"ver")
		local des=string.GetElementInItem(verInfo,"des")

		local context=UI.createContext(Context.retDialog,CSS.default)
		local rootView=context:getRootView()
		local dialogHeight=400
		local dialogWidht=Global.size.width*0.8
		rootView:setStyle(View.SetLayoutCenter(dialogWidht,dialogHeight))
		local viewTimeSpan=context:createView(Context.TimeSpan)
		viewTimeSpan:setStyle("width",dialogWidht)
		rootView:addSubview(viewTimeSpan)
		local timeSpan=View.BuildTimeSpan(viewTimeSpan,10)
		Context.BtnNormal.id="BtnOk"
		local BtnOkView=context:createView(Context.BtnNormal)
		BtnOkView:setActionCallback(UI.ACTION.CLICK, function(id,action) print("233") end)
		View.SetButtonStyle(Color3B(100,100,200),BtnOkView)
		rootView:addSubview(BtnOkView)
		--context:findView("BtnOk"):setActionCallback(UI.ACTION.CLICK, function(id,action) print("233") end)
		local BtnCancel=UI_Button:new()
		BtnCancel:Init(context,Context.BtnNormal,"BtnCancel",Color3B(200,100,100))
		BtnCancel:SetText("取消")
		BtnCancel.view:setActionCallback(UI.ACTION.CLICK, 
			function(id,action) print("233") end
		)
		BtnCancel:OnClick(function(id,action)
			timeSpan.timeCount=timeSpan.timeCount+5000
			print(action)
		end)
		rootView:addSubview(BtnCancel.view)
		
		anyUIShow=true
		context:show()
		context:findView("BtnCancel"):setActionCallback(UI.ACTION.CLICK, function(id, action)
			print("23333")
		end)
		while anyUIShow do
			sleep(1000)
			if timeSpan:Refresh() then
				anyUIShow=false
				context:close()
			end
		end
	end
end