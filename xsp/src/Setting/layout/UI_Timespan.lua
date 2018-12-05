UI_Timespan={
	timeCount=0,
	totalTime=0,
	view=nil,
	viewWidth=0,
	
	nowTimeCount=0
}

function UI_Timespan:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function UI_Timespan:Init(view,count)
	self.timeCount=os.milliTime()
	self.totalTime=count
	self.view=view
	self.viewWidth=self.view:getStyle("width")
end
function UI_Timespan:Refresh()
	local leftTime=self.totalTime-(os.milliTime()-self.timeCount)/1000
	self.nowTimeCount=self.nowTimeCount*0.9+leftTime*0.1
	if leftTime<0 then
		return true
	end
	local colorLen=math.floor(255*self.nowTimeCount/self.totalTime)
	local color=Color3B(255-colorLen,colorLen,0)
	self.view:setStyle("background-color",string.format("#%x",color:toValue()))
	self.view:setStyle("width",self.viewWidth*0.1*self.nowTimeCount)
	
	self.view:getSubview(1):setAttr("value",string.format("%.1fs",self.nowTimeCount))
	return false
end