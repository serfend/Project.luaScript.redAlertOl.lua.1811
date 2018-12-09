UI_Timespan={
	
}

function UI_Timespan:new (o)
    o = o or {}
	o.beginTimeStamp=0
	o.totalTime=0
	o.nowShowTimeLeft=0
	o.view=nil
	o.viewWidth=0
	return setmetatable(o, {__index=UI_Timespan})
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
	local colorStr=string.format("#%06x",color:toInt())
	self.view:setStyle("background-color",colorStr)
	self.view:setStyle("width",self.viewWidth*self.nowShowTimeLeft/self.totalTime)
	local txtView=self.view:getSubview(1)
	if txtView then
		txtView:setAttr("value",string.format("%.1fs",self.nowShowTimeLeft))
	else
		print("UI_Timespan.Refresh().Exception:TextViewIsNil")
	end
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