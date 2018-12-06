function party:TaskSignUpReward()
	local r,g,b=screen.getRGB(565,400) 
	if r>180 and g>120 and b<100 then
		ShowInfo.ResInfo("联盟任务签到奖励")
		tap(570,390)--签到按钮
		return true
	else
		if r==g and g==b and r>100 and r<140 then
			--奖励已领取状态
		else
			print("TaskSignUpReward.Exception()"..r..","..g..","..b)
		end
	end
	return false
end
function party:RunAttainTaskward()
	local todayValid=storage.get("party.task.todayValid",true)
	local lastUnhdlExceptionTime=storage.get("party.task.lastUnhdlExceptionTime",0)
	if todayValid then
		ShowInfo.ResInfo("领取任务奖励")
		tap(361,1214)--全部领取
		sleep(500)
		local r,g,b=screen.getRGB(288,1234)
		if r>50 and g>50 and b>50 then
			storage.put("party.task.todayValid",false)
			storage.put("party.task.lastUnhdlExceptionTime",os.milliTime()/1000)
			ShowInfo.ResInfo(string.format("任务奖励领取失败,stamp:%d",storage.get("party.task.lastUnhdlExceptionTime",0)))
		end
		MainForm:ExitForm()--返回上一层
		return true
	else
		local nowTime=os.milliTime()/1000
		local interval=math.floor(nowTime-lastUnhdlExceptionTime)
		if interval >14000 then
			storage.put("party.task.todayValid",true)
			ShowInfo.ResInfo(string.format("已超过%d秒，重新尝试领取",interval))
			return self:RunAttainTaskward()
		else
			storage.put("party.task.lastUnhdlExceptionTime",nowTime)
			ShowInfo.ResInfo("防封需要,4h内取消任务获取")
			return false
		end
	end
	
end

function party:CheckIfNewTaskward()
	if not Setting.Party.Task.Enable then
		return
	end
	local r,g,b=screen.getRGB(400,1065)--任务信息点
	if  (r>200 and g<100 and b<100) then
		return function()
			tap(356,974)--进入任务页面
			sleep(1000)
			if self:TaskSignUpReward() then
				sleep(500)
			end
			self:RunAttainTaskward()
		end
	end
	return false
end