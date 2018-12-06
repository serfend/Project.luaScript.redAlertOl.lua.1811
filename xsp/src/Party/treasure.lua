require "Party.treasure_Action"
require "Party.treasure_Info"
function party:RunSelfTreasure()
	ShowInfo.ResInfo("处理宝藏挖掘")
	tap(127,174)
	sleep(500)
	
	if self:CheckIfAnyPreasureToDig() then
		
	end
	tap(364,173)
	sleep(500)
	self:HandleSelfWaitAssistPreasure()--求助
	sleep(500)
	self:ReceivePreasure()
	
end
function party:RunAssistOtherTreasure()
	ShowInfo.ResInfo("帮助其他玩家")
	tap(587,173)
	sleep(2000)
	self:AssistOtherPreasure()
	
end
function party:RunTreasure()
	local anyTask={}
	local haveTask=false
	anyTask[1]=Setting.Party.Treasure.Self.Enable
	if anyTask[1] then anyTask[1]=function() 
		self:RunSelfTreasure() 
		end 
	else
		ShowInfo.ResInfo("宝藏挖掘被禁用")
	end
	anyTask[2]=Setting.Party.Treasure.AssistOther.Enable
	if anyTask[2] then 
		anyTask[2]=function() 
				self:RunAssistOtherTreasure() 
			end 
	else
		ShowInfo.ResInfo("协助盟友宝藏挖掘被禁用")
	end
	for k,taskInfo in ipairs(anyTask) do
		if taskInfo then--方法
			haveTask=true
			break
		end
	end
	if haveTask then
		tap(361,1204)--联盟宝藏按钮
		sleep(1000)
		for k,taskInfo in ipairs(anyTask) do
			if taskInfo then--方法
				if taskInfo() then--任务需要中断
					break
				end
			end
		end
		MainForm:ExitForm()
	end
	return haveTask
end
function party:CheckIfNewTreasure()
	if not Setting.Party.Treasure.Enable then
		return
	end
	local todayNewCheck=storage.get("party.treasure.todayNewCheck","")
	local needCheck=false
	if todayNewCheck==os.date("%Y-%m-%d") then
		local r,g,b=screen.getRGB(396,1170)--礼品信息点
		needCheck=(r>200 and g<100 and b<100)
	else
		storage.put("party.treasure.todayNewCheck",os.date("%Y-%m-%d"))
		needCheck=true
	end
	
	if needCheck  then
		return function()
			self:RunTreasure()
		end
	end
	return false
end