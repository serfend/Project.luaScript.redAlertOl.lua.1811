function setScreenScale(width, height)
    -- 对输入和输出结果进行转换
    screen.setMockMode(screen.MOCK_BOTH)
    screen.setMockTransform(function (mode, rect)
        -- 简单缩放兼容中, 不论mode是INPUT还是OUTPUT
        -- 都直接按对应缩放比例进行缩放即可
        local screenSize = screen.getSize()
        local scaleW, scaleH = width / Global.size.width, height / Global.size.height
        -- 将rect进行等比缩放, 返回修改后的rect
        rect.x = rect.x * scaleW
        rect.y = rect.y * scaleH
        rect.width = rect.width * scaleW
        rect.height = rect.height * scaleH
        return rect
    end)
end
Global={
	size={},dpi=0
}
_isDebug = false
_fitScreen=true
screen.init(screen.PORTRAIT)
Global.size=screen.getSize()
Global.dpi=screen.getDPI()
local supportSize=false
if  Global.size.width==1080 and Global.size.height==1920 and Global.dpi==480 then
	supportSize=true
else
	supportSize=false
end

if not supportSize then
	_fitScreen=false
	choiceIfRun = dialogRet(
		string.format("不支持当前分辨率\n 设备宽:%d 设备高:%d  dpi:%d\n强制运行无法保证脚本功能能够正常运转\n建议您使用:1080*1920:480分辨率的设备运行脚本",Global.size.width,Global.size.height,Global.dpi), 
	"停止运行", "强制运行", "", 0)
	if choiceIfRun == 0 then
		lua_exit()
	end
	setScreenScale(1080,1920)
	--dialog("出于用户体验考虑,\n强制运行已被管理员关闭\n您可以使用:\n模拟器或对应分辨率的手机运行脚本")
	--lua_exit()
end