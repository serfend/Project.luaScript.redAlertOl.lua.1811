--@summary:城市策略释放
--进入后下滑，通过识别所有策略中，有锁的策略来确定无锁的策略位置
--通过判断策略字体的颜色来判断当前是否可用
--可用则立即使用
Skill={
	lastRunTime={
	
	}
}
function Skill:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function Skill:Run()
	dialog("Skill:Run()no implement expection")
end
function Skill:Enter()
	tap(688,677)--策略按钮位置
	sleep(500)
	
end
function Skill:CheckIfAnySkill()
	
end