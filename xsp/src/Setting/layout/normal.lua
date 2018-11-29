View = {
	
}--初始化
function View:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

