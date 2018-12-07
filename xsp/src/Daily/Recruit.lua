--@summary:每天执行5次成功招募 
local lastTimeRefresh=0
local todayNewCheck=0
function Daily:RunRecruit()
	if not Setting.Daily.Recruit.Enable then
		ShowInfo.ResInfo("招募功能被禁用")
		return
	end
	Building.building:Navigate("英雄大厦")
	tap(360,789)
	sleep(5000)
	todayNewCheck=todayNewCheck+1
	self:SetRecruitTime(todayNewCheck)
end

function Daily:CheckIfNewRecruit()
	todayNewCheck=self:GetRecruitTime()
	if todayNewCheck>=5 then
		return false--当天已查询过则返回
	else
		ShowInfo.ResInfo("开始检查英雄大厦")
		return function() self:RunSupply() end
	end
end

function Daily:SetRecruitTime(times)
	storage.put("Daily.Recruit.todayNewCheck."..os.date("%Y-%m-%d"),times)
end
function Daily:GetRecruitTime()
	return storage.get("Daily.Recruit.todayNewCheck."..os.date("%Y-%m-%d"),0)
end