local panelPosX={
	[1]=296,[2]=507
}
local panelPosYBegin=352
local panelWidth=200
local panelHeight=150

local panelGreen="0|0|0x38a633,-102|2|0x3fae38,-52|9|0x42b33a"--实验室绿色
local panelBlue="0|0|0x516dc9,49|11|0x5773ce,94|3|0x4e6bc7"--实验室蓝色
local panelOrange="0|0|0xe26f30,-30|-2|0xbd4929,-101|-4|0xbb4928"--维修橙色
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
	panelPosX[indexX],panelPosYBegin+160*(indexY-1),
	panelWidth,panelHeight,colorInfo)
end
function pandect:PanelCheckRangeColor(x,y,w,h,colorInfo)
	local point = screen.findColor(Rect(x, y, w, h), 
	colorInfo,
	90, screen.PRIORITY_DEFAULT)
	return point.x>0
end