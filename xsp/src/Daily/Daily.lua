Daily={

}
require "Daily.DiscountStore"
require "Daily.Recruit"
require "Daily.Supply"
require "Daily.Task"
function Daily:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
--@summary:完成日常任务
function Daily:NewCheckDaily()
	ShowInfo.RunningInfo("<日常任务>")
	local anyTask={}
	screen.keep(true)
	anyTask[1]=self:CheckIfNewDailyTaskComplete()
	anyTask[2]=self:CheckIfNewRecruit()
	anyTask[3]=self:CheckIfNewSupply()
	anyTask[4]=self:CheckIfNewDiscountStore()
	screen.keep(false)
	for k,taskInfo in ipairs(anyTask) do
		if taskInfo then--方法
			if taskInfo() then--任务需要中断
				return false
			end
		end
	end
end