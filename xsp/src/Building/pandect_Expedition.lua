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
function pandect:DoExpedition(index)
	local targetInfo=Setting.Expedition.TargetInfo[index]
	
	local targetPos=self:PanelPos(expeditionInitInfo.Pos[index][1],expeditionInitInfo.Pos[index][2])
	tap(targetPos.x,targetPos.y)
	sleep(2000)
	if not Setting.Expedition.PlayerEnergySupply then--若无自动补充体力，则判断当前体力值
		self.nowPlayerEnergy=self:GetNowPlayerEnergySupply()
	end
	return self:ExpeditAction_OnTarget(targetInfo)
end

--@summary:检测当前面板上可供选择的部队
function pandect:RunIfAnyTroopsFree()
	local waitHandle={}
	screen.keep(true)
	for k,targetPos in ipairs(expeditionInitInfo.Pos) do 
		if self:PanelIsBlue(targetPos[1],targetPos[2]) then
			table.insert(waitHandle,k)
		else
		end
	end
	screen.keep(false)
	userEnergySupply=true
	for k,index in ipairs(waitHandle) do 
		if self:DoExpedition(index)==false then
			break
		else
			sleep(500)
			self:Enter(true)
			tap(self.cataButton[2],self.cataButtonY)
		end
	end
	return #waitHandle>0
end

