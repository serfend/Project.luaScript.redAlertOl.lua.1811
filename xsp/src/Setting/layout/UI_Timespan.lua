UI_Timespan={
	beginTimeStamp=0,
	totalTime=0,
	nowShowTimeLeft=0,
	view=nil,
	viewWidth=0,
	
	
}

function UI_Timespan:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
--@summary:初始化TimeSpan控件
--@param string id:控件id
--@param UIContext context:源布局
--@param table rawData:原始控件数据
--@param Color3B color:主题色
--@param int width:TimeSpan宽
--@param float totalTime:倒计时初始长度
function UI_Timespan:Init(id,context,rawData,color,width,totalTime)
	rawData.id=id
	self.beginTimeStamp=os.milliTime()
	self.totalTime=totalTime
	self.view=context:createView(rawData)
	self.viewWidth=width
end
function UI_Timespan:Refresh()
	local leftTime=self.totalTime-(os.milliTime()-self.beginTimeStamp)/1000
	self.nowShowTimeLeft=self.nowShowTimeLeft*0.9+leftTime*0.1
	if leftTime<0 then
		return true
	end
	local colorLen=math.floor(255*self.nowShowTimeLeft/self.totalTime)
	if colorLen>255 then colorLen=255 end
	local color=Color3B(255-colorLen,colorLen,0)
	self.view:setStyle("background-color",string.format("#%06x",color:toValue()))
	self.view:setStyle("width",self.viewWidth*self.nowShowTimeLeft/self.totalTime)
	
	self.view:getSubview(1):setAttr("value",string.format("%.1fs",self.nowShowTimeLeft))
	return false
end
--@summary:从布局中删除此控件
function UI_Timespan:Delete()
	self.parent:Delete(self.view:getID())
end

--@summary:编辑剩余时间
--@param float interval:变更时间值
function UI_Timespan:AddTime(interval)
	self.beginTimeStamp=self.beginTimeStamp+interval*1000
	local nowTimeStamp=os.milliTime()
	if self.beginTimeStamp>nowTimeStamp then
		self.beginTimeStamp=nowTimeStamp
	end
end

--@summary:编辑总时长
function UI_Timespan:AddTimeRange(length)

end