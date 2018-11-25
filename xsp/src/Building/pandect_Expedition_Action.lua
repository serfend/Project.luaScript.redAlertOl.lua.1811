function pandect:ExpeditAction_OnTarget(targetInfo)
	local requireEnergy=Const.Expedition.PlayerEnergy[targetInfo.Enemy]
	if self.nowPlayerEnergy< requireEnergy then
		ShowInfo.ResInfo(string.format("体力%s,不足%s",self.nowPlayerEnergy,requireEnergy))
		return false
	end
	self:SelectTargetInfo(targetInfo)
	self:CheckLastExpeditPos()
	return self:EnsureSelectTarget(targetInfo)
end
--@summary:决定当前选中
function pandect:EnsureSelectTarget(targetInfo)
	local success=false
	while not success do
		self:NowSelectExpeditionQueryNext()
		if self:CheckLastExpeditPos() then
			dialog("已无目标可选")
			return false
		end
		success=self:CheckCurrentIfNoOtherPlayer() 
	end
	self:SelectCurrentTarget(targetInfo.Action)
	sleep(1000)
	self:ExpeditWithTargetTroop(targetInfo.Troop)
	ShowInfo.ResInfo("编队已出征")
	return true
end
--@summary:使用设定的编队进行出征
--@param index:0-默认 1到4-编队 5-最高等级 6-最大负重 7-最快行军 8-均衡搭配
function pandect:ExpeditWithTargetTroop(index)
	if index>0 and index<5 then
		tap(300+90*index,170)--选中编队序号
	else
		if index>4 then
			tap(356,1209)--中间按钮
			sleep(500)
			tap(356,800+70*(index-4))--中间选项序号
		end
	end
	sleep(500)
	tap(560,1210)--出征按钮
end

--@summary:选中目标
--@param selectModel:0-弹窗 1-5:由左至右5个按钮
function pandect:SelectCurrentTarget(index)
	tap(360,640)--屏幕正中间
	sleep(1500)
	self:SelectMapTargetButton(index)
end
--@summary:选中目标按钮
function pandect:SelectMapTargetButton(index)
	if index==0 then
		tap(356,973)--攻击按钮
	else
		tap(Const.Expedition.TargetButton[index][1],Const.Expedition.TargetButton[index][2])
	end
end
--@summary:判断当前目标没有其他玩家所控制
function pandect:CheckCurrentIfNoOtherPlayer() 
	return true
end

--@summary:在出征模式下，依据出征目标信息选择目标
--@param targetInfo:{Enemy=index,Rank={max,min,now}}
function pandect:SelectTargetInfo(targetInfo)
	ShowInfo.ResInfo(string.format("选中【%s】等级:%s",
		Const.Expedition.EnemyDescription[targetInfo.Enemy],
		targetInfo.Rank.now
	))
	self:SelectTargetEnemy(targetInfo.Enemy)
	self:SelectTargetRank(targetInfo.Rank.now)
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