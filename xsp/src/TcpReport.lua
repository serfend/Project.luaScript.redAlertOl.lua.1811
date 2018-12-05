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
		uiHandle:NewDialog("newVersion",msg)
	end
end