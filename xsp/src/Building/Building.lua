--@summary:检测待建筑队列数量并按优先级进行建筑
--当优先级最高的建筑无法建筑时，对优先级次之的建筑进行升级
--可能会导致每次轮询时间过长
building={
	
}
require "Building.Building_Research"
function building:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function building:Run(activeMode)

end