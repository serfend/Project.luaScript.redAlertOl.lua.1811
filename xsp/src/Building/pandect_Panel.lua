local panelPosX={
	[1]=296,[2]=507
}
local panelPosYBegin=352
local panelWidth=200
local panelHeight=150

local panelGreen={rmax=100,rmin=0,gmax=255,gmin=150,bmax=100,bmin=0}
local panelBlue={rmax=100,rmin=0,gmax=150,gmin=50,bmax=255,bmin=150}
local panelOrange={rmax=255,rmin=150,gmax=100,gmin=0,bmax=100,bmin=0}
function pandect:PanelPos(indexX,indexY)
	return {x=panelPosX[indexX]+10,y=panelPosYBegin+160*(indexY-1)+10}
end
function pandect:PanelIsGreen(indexX,indexY)
	return self:PanelCheckColor(indexX,indexY,panelGreen)
end
function pandect:PanelIsBlue(indexX,indexY)
	return self:PanelCheckColor(indexX,indexY,panelBlue)
end
function pandect:PanelIsOrange(indexX,indexY)
	return self:PanelCheckColor(indexX,indexY,panelOrange)
end
function pandect:PanelCheckColor(indexX,indexY,colorInfo)
	return self:PanelCheckRangeColor(
	panelPosX[indexX]+40,panelPosYBegin+160*(indexY-1)+135,colorInfo)
end
function pandect:PanelCheckRangeColor(x,y,colorInfo)
	local result=true
	local tr,tg,tb=0,0,0
	for i=1,3 do
		local r,g,b=screen.getRGB(x+5*i,y)
		tr=tr+r
		tg=tg+g
		tb=tb+b
	end
	tr=tr/3
	tg=tg/3
	tb=tb/3
	result= colorInfo.rmax>tr and colorInfo.rmin<tr and colorInfo.gmax>tg and colorInfo.gmin<tg and colorInfo.bmax>tb and colorInfo.bmin<tb
	--showRectPos(x,y,1000,nil,result and "有效" or "无效")
	return result
end