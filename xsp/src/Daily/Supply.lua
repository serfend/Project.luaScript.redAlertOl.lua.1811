function self:RunSupply()
	if not Setting.Daily.Supply.Enable then
		ShowInfo.ResInfo("军需处被禁用")
		return
	end
end