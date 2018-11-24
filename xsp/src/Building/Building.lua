building={}
require "Building.Building_Research"
function building:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
