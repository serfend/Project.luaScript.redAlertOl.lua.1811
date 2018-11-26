
function pandect:GetNowRankRange()
	local rawPos=ocrInfo:GetMapTargetRank()
	print(string.format("rawRank:%s",rawPos))
	local checkIndex,_=string.find(rawPos,"%(")
	if checkIndex>0 then
		return string.sub(rawPos,checkIndex+1)
	else 
		checkIndex=string.find(rawPos,"/")
		if checkIndex>0 then
			return string.sub(rawPos,checkIndex+1)
		else
			return tonumber(rawPos)
		end
	end
end
--@summary:当前玩家体力值可供（由判断场景时检查橙色进度条获取）
--当用户开启了【自动补充体力】时则可无视体力值进入出征列表
function pandect:GetNowPlayerEnergySupply()
	screen.keep(true)
	local beginX=30
	local endX=89
	local judgeY=156
	local maxEnergy=Setting.Expedition.PlayerMaxEnergy
	local result=-1
	
	local emptyPosX=0
	local emptyTime=0
	for nowX=beginX,endX do
		local r,g,b=screen.getRGB(nowX,judgeY)
		if r<100 then
			if emptyTime==0 then
				emptyPosX=nowX
			end
			emptyTime=emptyTime+1
			if emptyTime>3 then
				result=math.floor(maxEnergy * (emptyPosX-beginX) / (endX-beginX))
				break
			end
		else
			emptyTime=0
		end
	end
	if result==-1 then result=100 end
	ShowInfo.ResInfo(string.format("玩家体力值:%d/%d",result,maxEnergy))
	screen.keep(false)
	return result
end
local lastExpeditPos={}
--@summary:检查当前坐标是否和上次一致，以此判断是否成功寻找目标
function pandect:CheckLastExpeditPos()
	local pos=ocrInfo:GetMapPos()
	local result= lastExpeditPos[pos]
	if not result then 
		lastExpeditPos[pos]=true
	end
	return result
end
function pandect:ClearLastPosGroup()
	lastExpeditPos={}
	self:CheckLastExpeditPos()
end