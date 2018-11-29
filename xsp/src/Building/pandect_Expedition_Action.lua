function pandect:ExpeditAction_OnTarget(targetInfo)
	
	local result=-4
	targetInfo.Rank.now=targetInfo.Rank.max
	while true do
		self:SelectTargetInfo(targetInfo)
		result=self:EnsureSelectTarget(targetInfo)
		if result==0 then
			break
		end
		targetInfo.Rank.now=targetInfo.Rank.now-1
		if targetInfo.Rank.now<targetInfo.Rank.min then
			ShowInfo.ResInfo("已无目标可选")
			return -4
		end
	end
	return 0
end
--@summary:决定当前选中
function pandect:EnsureSelectTarget(targetInfo)
	local success=false
	self:ClearLastPosGroup()
	while not success do
		self:NowSelectExpeditionQueryNext()
		
		screen.keep(true)
		if self:CheckLastExpeditPos() then
			screen.keep(false)
			return -4
		end
		success=self:CheckCurrentIfNoOtherPlayer() 
		if success then
			ShowInfo.ResInfo("发现目标,准备出征")
		else
			ShowInfo.ResInfo(string.format("有目标正在接近%s",MainForm.mapPos))
		end
		screen.keep(false)
	end
	self:SelectCurrentTarget(targetInfo.Action)
	sleep(1000)
	self:ExpeditWithTargetTroop(targetInfo.Troop)
	ShowInfo.ResInfo("编队已出征")
	return 0
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
	local result=false
	local point = screen.findColor(Rect(336, 474, 51, 52), 
"0|0|0x1fc32e,-4|-3|0x1ca22b",
95, screen.PRIORITY_DEFAULT)
	if point.x<1 then
		point = screen.findColor(Rect(336, 474, 51, 52), 
"0|0|0xd72522,6|-6|0xa82421",
95, screen.PRIORITY_DEFAULT)--没有被占领
		if point.x<0 then
			point = screen.findColor(Rect(333, 577, 52, 44), 
	"0|0|0xc70e1e",
	95, screen.PRIORITY_DEFAULT)--是否有红色
			if point.x>0 then
				if point.x>360 or point.y>640 then
					result= true--红色不在左上角则表明无聚焦点
				else
					r,g,b=screen.getRGB(720-point.x,1280-point.y)
					if r>150 and g<100 and b<100 then
						result= false--确实有人在集火
					else	
						print("目标确认无误"..r)
						result= true
					end
				end
			else
				result= true
			end
		else
			result= true
		end
	else
		result= false
	end
	return result
end

--@summary:在出征模式下，依据出征目标信息选择目标
--@param targetInfo:{Enemy=index,Rank={max,min,now}}
function pandect:SelectTargetInfo(targetInfo)
	ShowInfo.ResInfo(string.format("选中 %s 等级:%d",
		Const.Expedition.Description[targetInfo.Enemy],
		targetInfo.Rank.now
	))
	self:SelectTargetEnemy(targetInfo.Enemy)
	self:SelectTargetRank(targetInfo.Rank.now)
end
function pandect:SelectTargetEnemy(index,notReset)
	if not notReset then
		swip(20,990,648,990)
		sleep(500)
	end
	if index>6 then
		swip(648,990,648-120-30,990)--宽120+延迟移动35
		sleep(500)
		self:SelectTargetEnemy(index-1,true)
		return
	else
		tap((index-1)*120+50,990)--宽为120，初始50
		sleep(200)
	end
	
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
	if math.abs(nowPos.x-targetX)>0.2*(endX-beginX)/nowRankRange then
		swip(nowPos.x,nowPos.y,targetX,1182,5)--进度条位置在y:1182
	end
end