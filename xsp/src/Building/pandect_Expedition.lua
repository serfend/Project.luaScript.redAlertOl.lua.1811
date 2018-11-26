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
	if not targetInfo.Enemy or targetInfo.Enemy==0 then
		ShowInfo.ResInfo(string.format("出征%s未设置目标",expeditionInitInfo.Pos[index][3]))
		return -1
	end
	local targetPos=self:PanelPos(expeditionInitInfo.Pos[index][1],expeditionInitInfo.Pos[index][2])
	tap(targetPos.x,targetPos.y)
	sleep(2000)
	if not Setting.Expedition.PlayerEnergySupply then--若无自动补充体力，则判断当前体力值
		self.nowPlayerEnergy=self:GetNowPlayerEnergySupply()
	end
	return self:ExpeditAction_OnTarget(targetInfo)
end
--@summary:二次询问时，不再检查这些队列
local banTroopQueue={}
--@summary:检测当前面板上可供选择的部队
function pandect:RunIfAnyTroopsFree()
	local waitHandle={}
	local invalidCount=0
	local nowCount=0
	screen.keep(true)
	for k,targetPos in ipairs(expeditionInitInfo.Pos) do 
		if self:PanelIsBlue(targetPos[1],targetPos[2]) and not banTroopQueue[k] then
			table.insert(waitHandle,k)
		end
	end
	screen.keep(false)
	userEnergySupply=true
	
	for k,index in ipairs(waitHandle) do 
		local result=self:DoExpedition(index)
		if result<0 then
			if result==-2 then
				break
			else if result==-1 then
					invalidCount=invalidCount+1
				else if result==-4 then
						banTroopQueue[index]=true
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
			end
		end
	end
	return (#waitHandle-invalidCount)>0
end

