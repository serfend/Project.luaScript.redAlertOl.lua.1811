
_isDebug = false
_fitScreen=true
_fsw, _fsh = getScreenSize()
_sw = _fsh - 1
_sh = _fsw - 1
_userDpi=getScreenDPI()
_orientation = 0--dialogRet("请选择您设备的放置方式：", "", "Home键在右", "Home键在左", 0)
setSysConfig("isLogFile","1")
toast(string.format("%s*%s:%s" ,_fsw, _fsh,_userDpi) )
printf("%s*%s:%s" ,_fsw, _fsh,_userDpi )
local supportSize=false
if  _fsw==720 and _fsh==1280 and _userDpi==320 then
	supportSize=true
else
	supportSize=false
end
if not supportSize then
	_fitScreen=false
	choiceIfRun = dialogRet("不支持当前分辨率".._fsw.."*".._fsh.."\n 强制运行无法保证脚本功能能够正常运转", "停止运行", "强制运行", "", 0)
	if choiceIfRun == 0 then
		lua_exit();
	end
	setScreenScales(720,1280)
end