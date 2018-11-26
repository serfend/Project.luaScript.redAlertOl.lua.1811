local todayValid=true
local lastUnhdlExceptionTime=0
function party:RunAttainTaskward()
	if not todayValid then
		if os.milliTime()-lastUnhdlExceptionTime >1000*86400 then
			todayValid=true
		else
			ShowInfo.ResInfo("防封需要,24h内取消任务获取")
			return false
		end
	end
	tap(356,974)
	sleep(1000)
	tap(361,1214)--全部领取
	sleep(500)
	local r,g,b=screen.getRGB(288,1234)
	if r>50 and g>50 and b>50 then
		todayValid=false
	end
	--TODO 此处需要添加确定键
	MainForm:ExitForm()--返回上一层
	return true
end

function party:CheckIfNewTaskward()
	if not Setting.Party.Task.Enable then
		return
	end
	local r,g,b=screen.getRGB(400,1065)--任务信息点
	if  (r>200 and g<100 and b<100) then
		return function()
			self:RunAttainTaskward()
		end
	end
	return false
end