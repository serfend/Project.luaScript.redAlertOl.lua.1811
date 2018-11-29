local expeditionInitInfo={
	Pos={
		[1]={[1]=1,[2]=1,[3]="队列1"},
		[2]={[1]=2,[2]=1,[3]="队列2"},
		[3]={[1]=1,[2]=2,[3]="队列3"},
		[4]={[1]=2,[2]=2,[3]="队列4"},
		[5]={[1]=1,[2]=3,[3]="队列5"}
	}
}
require "Building.pandect_Expedition_Action"
require "Building.pandect_Expedition_Info"
--@summary:指定队列出征，0:正常 -1:未设置目标 -2:无体力 -4:无可用目标
function pandect:DoExpedition(index)
	local targetInfo=Setting.Expedition.TargetInfo[index]
	if not targetInfo or not targetInfo.Enemy or targetInfo.Enemy==0 then
		ShowInfo.ResInfo(string.format("出征%s未设置目标",expeditionInitInfo.Pos[index][3]))
		return -1
	end
	
	local requireEnergy=Const.Expedition.PlayerEnergy[targetInfo.Enemy]
	if self.nowPlayerEnergy-requireEnergy<Setting.Expedition.PlayerEnergyPreserve then
		ShowInfo.ResInfo(string.format("本次出征后,体力%d-%d=%d,不足%d",self.nowPlayerEnergy,
		requireEnergy,self.nowPlayerEnergy-requireEnergy,Setting.Expedition.PlayerEnergyPreserve))
		targetInfo=Setting.Expedition.NoEnergyTargetInfo[index]
		if targetInfo then
			if Const.Expedition.PlayerEnergy[targetInfo.Enemy]>=requireEnergy then
				ShowInfo.ResInfo(string.format("休眠模式体力消耗仍旧过高%d",Const.Expedition.PlayerEnergy[targetInfo.Enemy]))
				return -2
			else
				if Setting.Expedition.PlayerNoEnergyTargetEnable then
					ShowInfo.ResInfo("转入体力不足模式")
				else
					ShowInfo.ResInfo("体力不足模式 被禁用")
					return -2
				end
			end
		else
			return -2
		end
	end
	
	local targetPos=self:PanelPos(expeditionInitInfo.Pos[index][1],expeditionInitInfo.Pos[index][2])
	tap(targetPos.x,targetPos.y)
	sleep(2000)
	return self:ExpeditAction_OnTarget(targetInfo)
end
--@summary:二次询问时，不再检查这些队列

--@summary:检测当前面板上可供选择的部队
function pandect:RunIfAnyTroopsFree()
	local waitHandle={}
	local invalidCount=0
	local nowCount=0
	screen.keep(true)
	for k,targetPos in ipairs(expeditionInitInfo.Pos) do 
		if self:PanelIsBlue(targetPos[1],targetPos[2]) and not self.banTroopQueue[k] then
			table.insert(waitHandle,k)
		end
	end
	screen.keep(false)
	
	for k,index in ipairs(waitHandle) do 
		local result=self:DoExpedition(index)
		if result<0 then
			if result==-2 then
				self.banTroopQueue[index]=true
				invalidCount=invalidCount+1
			else if result==-1 then
					invalidCount=invalidCount+1
				else if result==-4 then
						self.banTroopQueue[index]=true
						break
					end
				end
			end
		else
			nowCount=nowCount+1
			sleep(500)
			--当当前完成数量小于剩余可用数量时，则返回出征界面
			if nowCount<#waitHandle-invalidCount then
				self:Enter(true)
				tap(self.cataButton[2],self.cataButtonY)
				sleep(600)
			end
		end
	end
	return (#waitHandle-invalidCount)>0
end

