ToolBar = {
	nowState=0,
}--初始化
function ToolBar:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function ToolBar:CheckIfInCity()

end
function ToolBar:CheckIfInWorld()

end
----@su
--function ToolBar:CheckIfHaveMsg(index)