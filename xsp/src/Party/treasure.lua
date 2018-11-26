function party:RunSelfTreasure()
	ShowInfo.ResInfo("处理宝藏挖掘")
end
function party:RunAssistOtherTreasure()
	ShowInfo.ResInfo("帮助其他玩家")
end
function party:RunTreasure()
	local anyTask={}
	local haveTask=false
	anyTask[1]=Setting.Party.Treasure.Self.Enable
	if anyTask[1] then anyTask[1]=function() self:RunSelfTreasure() end end
	anyTask[2]=Setting.Party.Treasure.AssistOther.Enable
	if anyTask[2] then anyTask[2]=function() self:RunAssistOtherTreasure() end end
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
	local r,g,b=screen.getRGB(253,1170)--礼品信息点
	if  (r>200 and g<100 and b<100) then
		return function()
			self:RunTreasure()
		end
	end
	return false
end