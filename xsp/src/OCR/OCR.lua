OcrInfo={
	fore={
		mapPos="0xe1e0e0-0xa0a0a0",
		mapTargetRank="0xa99956-0xa0a022",
		PandectLeftTime="0x99894d-0x41ffff",
	}
}
function OcrInfo:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function OcrInfo:GetMapTargetRank()
	local code,result=ocr:GetMapPos(255,1125,61,20,self.fore.mapTargetRank)
	return result
end
--@summary:获取总览剩余时间
function OcrInfo:GetPandectLeftTime(x,y,w,h)
	local code,result=ocr:GetMapPos(x,y,w,h,self.fore.PandectLeftTime)
	return result
end

--@summary:需保证当前在地图场景下
function OcrInfo:GetMapPos()
	local judgeY=155
	screen.keep(true)
	local x1,x2=self:GetMapPosRange(judgeY)
	x1=x1+2
	x2=x2-2
	judgeY=judgeY-5
	local code,result=ocr:GetMapPos(x1,judgeY,x2-x1,25,self.fore.mapPos)
	screen.keep(false)
	return result
end
--@summary:通过识别白色区域获取坐标开始点和结束点
function OcrInfo:GetMapPosRange(judgeY)
	local beginX=364
	local endX=490
	
	local resultX1=0
	local resultX2=0
	for nowX=beginX,endX do
		local r,g,b=screen.getRGB(nowX,judgeY)
		if r>100 and g>100 and b>100 then
			resultX1=nowX
			break
		end
	end
	for nowX=endX,beginX,-1 do
		local r,g,b=screen.getRGB(nowX,judgeY)
		if r>100 and g>100 and b>100 then
			resultX2=nowX
			break
		end
	end
	return resultX1,resultX2
end