
function party:AssistOtherPreasure()
	self:ReceivePreasure()
	local targets=self:GetAssistOtherPreasure()
	for k,p in ipairs(targets) do
		ShowInfo.ResInfo(string.format("协助盟友挖掘%d阶宝藏",p.Type))
		tap(p.x,p.y)
		sleepWithCheckEnemyConquer(1000)
	end
end
function party:HandleSelfWaitAssistPreasure()
	local targets=self:GetSelfWaitAssistPreasure()
	for k,p in ipairs(targets) do
		ShowInfo.ResInfo(string.format("请求帮助%d阶宝藏",p.Type))
		tap(p.x,p.y)
		sleepWithCheckEnemyConquer(1500)
		return self:HandleSelfWaitAssistPreasure()
	end
end

--@summary:检查含有【领】字样的黄色按钮
function party:ReceivePreasure()
	local point = screen.findColor(Rect(540, 310, 154, 843), 
"0|0|0xfffefe,0|14|0xcc8f46,17|14|0xfefdfc,17|5|0xfffefe",
95, screen.PRIORITY_DEFAULT)
	if point.x>0 then
		ShowInfo.ResInfo("领取宝藏")
		tap(point.x,point.y)
		sleepWithCheckEnemyConquer(1000)
		return true
	else
		return false
	end
end

function party:CheckIfAnyPreasureToDig()
	local diggers=self:GetSelfWaitDigPreasure()
	for k,setting in ipairs(Setting.Party.Treasure.Self.TreasureSort) do
		for k2,target in ipairs(diggers) do
			if setting==target.Type then--等级匹配
				ShowInfo.ResInfo(string.format("选中%d阶宝藏",setting))
				tap(target.x,target.y)
				sleepWithCheckEnemyConquer(500)
				return true
			end
		end
	end
	ShowInfo.ResInfo("【没有找到合适的宝藏】")
	return false
end