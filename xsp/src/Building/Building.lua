--@summary:检测待建筑队列数量并按优先级进行建筑
--当优先级最高的建筑无法建筑时，对优先级次之的建筑进行升级
--可能会导致每次轮询时间过长
CityBuilding={
	ConstructQueueFree={[1]=false,[2]=false},
}
require "Building.Building_Research"
require "Building.Building_Info"
require "Building.Building_Action"
function CityBuilding:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function CityBuilding:Run(activeMode)
	if not activeMode then 
		return 
	end
	self.ConstructQueueFree[1]=false
	self.ConstructQueueFree[2]=false
	ResetForm()
	ShowInfo.RunningInfo("<建筑>")
	sleep(2000)
	self:CheckFreeQueueNum()
	self:UpLevelBuilding()
end