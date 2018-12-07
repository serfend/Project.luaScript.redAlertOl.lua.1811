--@summary:日常任务,活跃宝箱接收


--@summary:在城市界面下,检查是否有宝箱可领取
function Daily:CheckIfNewDailyTaskComplete()
	local r,g,b=screen.getRGB(684,1055)
	if r>180 and g<50 and b<50 then
		return function() self:DailyTaskRun() end
	else
		return false
	end
end

--@summary:进入日常任务进行领取
--//TODO 可考虑增加智能识别任务类型并进行完成
function Daily:DailyTaskRun()
	ShowInfo.ResInfo("日常任务奖励")
	tap(658,1066)--日常任务按钮
	sleep(800)
	local anyTask={}
	anyTask[1]=self:CheckIfDailyTaskActivityAward()
	anyTask[2]=self:CheckIfDailyTaskNormalTask()
	for i,v in ipairs(anyTask) do
		if v then
			v()
		end
	end
end

--@summary:检查是否每日任务上有红点
function Daily:CheckIfDailyTaskActivityAward()
	local r,g,b=screen.getRGB(331,161)
	if r>180 and g<50 and b <50 then
		return function() self:RunDailyTaskActivityAward() end
	else
		return false
	end
end

--@summary:检查是否使命任务上有红点
function Daily:CheckIfDailyTaskNormalTask()
	local r,g,b=screen.getRGB(574,162)
	if r>180 and g<50 and b<50 then
		return function() self:RunDailyTaskNormalTask() end
	else
		return false
	end
end

function Daily:RunDailyTaskActivityAward()
	ShowInfo.ResInfo("完成活跃任务")
	tap(255,179)--每日任务按钮
	sleep(800)
	local points = screen.findColors(Rect(94, 263, 600, 195), 
"0|0|0xffd92e,0|-23|0xfffaeb,-22|-6|0xffe850",
95, screen.PRIORITY_DEFAULT)
	points=exceptPosTableByNewtonDistance(points,20)
	for i,k in ipairs(points) do
		tap(k.x-5,k.y-5)
		sleep(1000)
		tap(359,965)--领取
	end
end

function Daily:RunDailyTaskNormalTask()
	tap(482,174)--使命任务按钮
	sleep(800)
	while self:CompleteDailyTaskNormalTask() do
		sleep(1000)
	end
end

function Daily:CompleteDailyTaskNormalTask() 
	local anyTask=false
	local r,g,b=screen.getRGB(660,375)
	if r>150 and g>100 and b<100 then
		tap(621,358)--推荐任务的领取按钮
		sleep(500)
		anyTask=true
		ShowInfo.ResInfo("完成使命任务")
	end
	local r2,g2,b2=screen.getRGB(675,585)
	if r2>150 and g2>100 and b2<100 then
		tap(628,578)--第一个常规任务的领取按钮
		sleep(500)
		anyTask=true
		ShowInfo.ResInfo("完成常规任务")
	end
	return anyTask
end