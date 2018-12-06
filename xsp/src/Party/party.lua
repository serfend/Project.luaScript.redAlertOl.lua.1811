party={
	cataButton={
		[1]=350,[2]=500,[3]=650
	},
	cataButtonY=300,
}
require "Party.treasure"
require "Party.task"
require "Party.gift"
require "Party.donation"
function party:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function party:Enter()
	tap(550,1230)
	sleepWithCheckEnemyConquer(1500)
	local point = screen.findColor(Rect(21, 65, 72, 46), 
"0|0|0xf5fcff,37|10|0x305774,26|20|0x38789f",
95, screen.PRIORITY_DEFAULT)
	return point.x>0
end
function party:Run()
	local anyTask={}
	screen.keep(true)
	anyTask[1]=self:CheckIfNewTreasure()
	anyTask[2]=self:CheckIfNewTaskward()
	anyTask[3]=self:CheckIfNewGift()
	anyTask[4]=self:CheckIfDonation()
	screen.keep(false)
	for k,taskInfo in ipairs(anyTask) do
		if taskInfo then--方法
			if taskInfo() then--任务需要中断
				return false
			end
		end
	end
	self:Exit()
	return true
end
function party:Exit()
	MainForm:ExitForm(true)
end
--@summary:联盟难免会有信息，请在主动操作中再行调用
function party:NewCheckParty()
	if not MainForm.lastScene==1 then
		ResetForm()
	end
	
	if not self:CheckIfPartyAction() then
		return
	end
	ShowInfo.RunningInfo("管理联盟")
	if self:Enter() then
		self:Run()
	else
		ShowInfo.ResInfo("进入联盟界面失败")
	end
end
function party:CheckIfPartyAction()
	if not toolBar:CheckIfHaveMsg(4) then
		ShowInfo.ResInfo("联盟无消息处理")
		return false
	end
	return true
end