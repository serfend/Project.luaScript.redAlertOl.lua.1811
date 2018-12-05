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
		rootView:addSubview(viewTimeSpan)
		local BtnOkView=context:createView(Context.BtnNormal)
		BtnOkView:setAttr("id","btnOk")
		View.SetButtonStyle(Color3B(200,100,100),BtnOkView)
		rootView:addSubview(BtnOkView)
		local BtnCancelView=context:createView(Context.BtnNormal)
		BtnCancelView:setAttr("id","btnCancel")
		rootView:addSubview(BtnCancelView)
		rootView:setActionCallback(UI.ACTION.CLICK, function()
			context:close()
			anyUIShow = false
		end)
		anyUIShow=true
		context:show()
		local timeCount=os.milliTime()
		while anyUIShow do
			sleep(10)
			local leftTime=10-(os.milliTime()-timeCount)/1000
			if leftTime<0 then
				anyUIShow=false
				context:close()
				return
			end
			viewTimeSpan:setStyle("width",dialogWidht*0.1*leftTime)
			viewTimeSpan:getSubview(1):setAttr("value",string.format("%ds",math.floor(leftTime)))
--			local timeSpanSubview=viewTimeSpan:getSubview(1)
--			timeSpanSubview.value=leftTime
		end
	end
end