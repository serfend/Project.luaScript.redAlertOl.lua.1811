function self:RunRecruit()
	if not Setting.Daily.Recruit.Enable then
		ShowInfo.ResInfo("招募功能被禁用")
	end
end