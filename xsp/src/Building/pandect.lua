--总览
pandect={
	cataButton={
		[1]=350,[2]=500,[3]=650
	},
	cataButtonY=300,
	Expedition={
		nowQueue
	},
	banTroopQueue={}
}
require "Building.pandect_Other"
require "Building.pandect_Conscript"
require "Building.pandect_Panel"
require "Building.pandect_Expedition"
function pandect:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function pandect:NewCheckPandect(activeMode)
	local enterPandect=Building.pandect:Enter(activeMode)
	if enterPandect==0 then
		self:Run()
	else
		if enterPandect==-2 then 
			ShowInfo.ResInfo("进入总览失败") 
			return -2
		end
	end
end
function pandect:SynPlayerEnergy()
	if not Setting.Expedition.PlayerEnergySupply then--若无自动补充体力，则判断当前体力值
		self.nowPlayerEnergy=self:GetNowPlayerEnergySupply()
	end
end
function pandect:Enter(directEnter)
	local pandectNewEnterButton="0|0|0xff0000,10|-2|0x432b24"
	local pandectEnterButton="0|0|0xf0f4f6,18|3|0xeff5fd"
	local point={}
	if directEnter then
		point={x=700,y=570}
	else
		point = screen.findColor(Rect(692, 536, 28, 27), pandectNewEnterButton,
	95, screen.PRIORITY_DEFAULT)
	end
	if point.x>0 then
		self:SynPlayerEnergy()
		tap(point.x,point.y+30)
		sleep(1000)
		point = screen.findColor(Rect(216, 542, 62, 76), pandectEnterButton,
95, screen.PRIORITY_DEFAULT)
		if point.x>0 then
			return 0
		else
			return -2
		end
	else
		return -1
	end
end
function pandect:Exit()
	MainForm:ExitForm()
end
function pandect:Run()
	ShowInfo.RunningInfo("总览操作")

	self:RunConscript() 
	if self:RunExpedition() then--当执行了出征后需重新开始
		self:NewCheckPandect(true)
		return
	end	
	if not self:RunOther() then
		self:NewCheckPandect(true)
		return
	end
	self:Exit()
end
--@summary:运行前重置上次的设置
function pandect:ResetSetting()
	self.banTroopQueue={}
	self.banTroopQueueAll=false
end
function pandect:RunConscript()
	ShowInfo.RunningInfo("<生产军备>")
	tap(self.cataButton[1],self.cataButtonY)
	sleepWithCheckEnemyConquer(500)
	self:RunIfAnyConscript()
end
function pandect:RunExpedition()
	if self.banTroopQueueAll then
		ShowInfo.ResInfo("当前出征无效,已跳过")
		return false
	end
	ShowInfo.RunningInfo("<出征>")
	tap(self.cataButton[2],self.cataButtonY)
	sleepWithCheckEnemyConquer(500)
	return self:RunIfAnyTroopsFree()
end
--@summary:执行面板3的任务
--@return:任务是否执行完成
function pandect:RunOther()
	ShowInfo.RunningInfo("其他选项")
	tap(self.cataButton[3],self.cataButtonY)
	sleepWithCheckEnemyConquer(500)
	screen.keep(true)
	local anyTask={}
	anyTask[1]=self:CheckIfSupply()
	anyTask[2]=self:CheckIfResearch()--填入作战实验室
	anyTask[3]=self:CheckIfTreat()--TODO 修复任务最后执行
	screen.keep(false)
	for k,taskInfo in ipairs(anyTask) do
		if taskInfo then--方法，坐标，内容
			if taskInfo() then--任务需要中断
				return false
			end
		end
	end
	return true
end