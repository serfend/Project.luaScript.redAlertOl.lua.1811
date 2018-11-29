Global={
	size={},dpi=0
}
_isDebug = false
_fitScreen=true
screen.init(screen.PORTRAIT)
Global.size=screen.getSize()
Global.dpi=screen.getDPI()
local supportSize=false
if  Global.size.width==720 and Global.size.height==1280 and Global.dpi==320 then
	supportSize=true
else
	supportSize=false
end
if not supportSize then
	_fitScreen=false
	choiceIfRun = dialogRet(
		string.format("不支持当前分辨率%dw*%dh:%ddpi\n 强制运行无法保证脚本功能能够正常运转",Global.size.width,Global.size.height,Global.dpi), 
	"停止运行", "强制运行", "", 0)
	if choiceIfRun == 0 then
		lua_exit();
	end
	setScreenScales(720,1280)
end