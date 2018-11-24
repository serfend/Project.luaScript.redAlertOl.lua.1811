--总览
pandect={
	cataButton={
		[1]=350,[2]=500,[3]=650
	},
	cataButtonY=300,
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
function pandect:Enter(directEnter)
	local pandectNewEnterButton="0|0|0xff0000,10|-2|0x432b24"
	local pandectEnterButton="0|0|0xf0f4f6,18|3|0xeff5fd"
	local point={}
	if directEnter then
		point={x=680,y=540}
	else
		point = screen.findColor(Rect(692, 536, 28, 27), pandectNewEnterButton,
	95, screen.PRIORITY_DEFAULT)
	end
	if point.x>0 then
		tap(point.x,point.y+5)
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
	tap(20,50)
end
function pandect:Run()
	self:RunConscript() 
	self:RunExpedition() 
	self:RunOther() 
	self:Exit()
end

function pandect:RunConscript()
	tap(self.cataButton[1],self.cataButtonY)
	sleep(500)
	self:RunIfAnyConscript()
end
function pandect:RunExpedition()
	tap(self.cataButton[2],self.cataButtonY)
	sleep(500)
end

function pandect:RunOther()
	tap(self.cataButton[3],self.cataButtonY)
	sleep(500)
	screen.keep(true)
	local anyTask={}
	anyTask[1]=self:CheckIfResearch()--填入作战实验室
	anyTask[2]=self:CheckIfSupply()
	anyTask[3]=self:CheckIfTreat()--TODO 修复任务最后执行
	screen.keep(false)
	for k,taskInfo in ipairs(anyTask) do
		if taskInfo then--方法，坐标，内容
			taskInfo()
		end
	end
	
end