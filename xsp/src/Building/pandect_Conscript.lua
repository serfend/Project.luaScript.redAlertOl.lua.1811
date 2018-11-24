--@summary:总览.生产军备
local conscriptInitInfo={
	conscriptPos={
		[1]={[1]=1,[2]=1,[3]="坦克"},
		[2]={[1]=2,[2]=1,[3]="空军"},
		[3]={[1]=1,[2]=2,[3]="兵营"},
		[4]={[1]=2,[2]=2,[3]="战车"},
		[5]={[1]=1,[2]=3,[3]="城防"}
	}
}
function pandect:RunIfAnyConscript()
	local waitHandle={}
	local anyAction=false--是否执行了任何操作
	screen.keep(true)
	for k,targetPos in ipairs(conscriptInitInfo.conscriptPos) do 
		if self:PanelIsGreen(targetPos[1],targetPos[2]) then
			local enterPos=self:PanelPos(targetPos[1],targetPos[2])
			tap(enterPos.x,enterPos.y)
			table.insert(waitHandle,k)
			anyAction=true
			sleep(800)
		else if self:PanelIsBlue(targetPos[1],targetPos[2]) then
				--等待处理
			table.insert(waitHandle,k)
			end
		end
	end
	screen.keep(false)
	if anyAction then sleep(1000) end
	for k,index in ipairs(waitHandle) do 
		self:DoConscript(index)
	end
end
--@summary:执行生产
--@param index:执行生产的序号
function pandect:DoConscript(index)
	local targetPos=self:PanelPos(conscriptInitInfo.conscriptPos[index][1],conscriptInitInfo.conscriptPos[index][2])
	tap(targetPos.x,targetPos.y)
	sleep(1000)--进入招兵页面
	if self:CheckIfConscripting() then
	
	else
		tap(530,1210)--直接开始
		sleep(500)
	end
end
function pandect:CheckIfConscripting()
	local point = screen.findColor(Rect(662, 1069, 21, 23), 
"0|0|0x355c96,10|0|0x1a120d",
95, screen.PRIORITY_DEFAULT)
	return point.x>0
end