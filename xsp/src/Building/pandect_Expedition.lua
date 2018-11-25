local expeditionInitInfo={
	Pos={
		[1]={[1]=1,[2]=1,[3]="队列1"},
		[2]={[1]=2,[2]=1,[3]="队列2"},
		[3]={[1]=1,[2]=2,[3]="队列3"},
		[4]={[1]=2,[2]=2,[3]="队列4"},
		[5]={[1]=1,[2]=3,[3]="队列5"}
	}
}
function pandect:DoExpedition(index)
	local targetPos=self:PanelPos(expeditionInitInfo.Pos[index][1],expeditionInitInfo.Pos[index][2])
	tap(targetPos.x,targetPos.y)
	sleep(1000)
	screen.keep(true)
	local targetInfo=Setting.Expedition.TargetInfo[index]
	self:SelectTargetInfo(targetInfo)
	self:CheckLastExpeditPos()
	screen.keep(false)
	self:NowSelectExpeditionQueryNext()
	if self:CheckLastExpeditPos() then
		dialog("已无目标可选")
		
	end
end
--@summary:在出征模式下，依据出征目标信息选择目标
--@param targetInfo:{Enemy=index,Rank=rank}
function pandect:SelectTargetInfo(targetInfo)
	self:SelectTargetEnemy(TargetInfo.Enemy)
	self:SelectTargetRank(targetInfo.Rank)
end
function pandect:SelectTargetEnemy(index)
	if index>6 then--仅只有7，基地
		swip(648,990,20,990)
		sleep(500)
		tap(648,990)
	else
		swip(20,990,648,990)
		sleep(500)
		tap((index-1)*120+50,990)--宽为120，初始50
	end
	sleep(200)
end
--@summary:点击【查找】按钮位置
function pandect:NowSelectExpeditionQueryNext()
	tap(600,1180)
	sleep(500)
end
function pandect:SelectTargetRank(index)
	local nowRankRange=self:GetNowRankRange()
	local beginX=107
	local endX=420
	local targetX=beginX+((index-1)*(endX-beginX))/nowRankRange
	local nowPos=screen.findColor(Rect(100, 1167, 330, 37), 
"0|0|0xdb8621,7|0|0xd6d3b0,12|0|0x050507",
95, screen.PRIORITY_DEFAULT)
	if nowPos.x==-1 then nowPos={x=420,y=1182} end
	swip(nowPos.x,nowPos.y,targetX,1182,5)--进度条位置在y:1182
end
function pandect:GetNowRankRange()
	local rawPos=ocrInfo:GetMapTargetRank()
	local checkIndex=string.find(rawPos,'(')
	if checkIndex>0 then
		return string.sub(rawPos,checkIndex+1)
	else 
		checkIndex=string.find(rawPos,'/')
		if checkIndex>0 then
			return string.sub(rawPos,checkIndex+1)
		else
			return tonumber(rawPos)
		end
	end
end
local userEnergySupply=false
--@summary:检测当前面板上可供选择的部队
function pandect:RunIfAnyTroopsFree()
	local waitHandle={}
	screen.keep(true)
	for k,targetPos in ipairs(expeditionInitInfo.Pos) do 
		if self:PanelIsBlue(targetPos[1],targetPos[2]) then
			table.insert(waitHandle,k)
		end
	end
	screen.keep(false)
	userEnergySupply=true
	for k,index in ipairs(waitHandle) do 
		self:DoExpedition(index)
		if userEnergySupply==false then 
			break
		end
	end
end

--@summary:当前玩家体力值可供（由判断场景时检查橙色进度条获取）
--当用户开启了【自动补充体力】时则可无视体力值进入出征列表
function pandect:GetPlayerEnergySupply()
	local beginX=30
	local endX=89
	local judgeY=156
	
end
local lastExpeditPos=""
--@summary:检查当前坐标是否和上次一致，以此判断是否成功寻找目标
function pandect:CheckLastExpeditPos()
	local pos=ocrInfo:GetMapPos()
	local result= (pos==lastExpeditPos)
	lastExpeditPos=Pos
	return result
end