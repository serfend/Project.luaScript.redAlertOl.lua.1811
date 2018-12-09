--@summary:每天仅进行一次

function Daily:RunSupply()
	if not Setting.Daily.Supply.Enable then
		ShowInfo.ResInfo("军需处被禁用")
		return
	end
	storage.put("Daily.Supply.todayNewCheck",os.date("%Y-%m-%d"))
end

function Daily:CheckIfNewSupply()
	local todayNewCheck=storage.get("Daily.Supply.todayNewCheck","")
	if todayNewCheck==os.date("%Y-%m-%d") then
		return false--当天已查询过则返回
	else
		ShowInfo.ResInfo("开始检查军需处")
		return function() self:RunSupply() end
	end
end