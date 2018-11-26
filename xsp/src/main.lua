require "Setting.usingPack"
require "Setting.UserSettingBase"
require "util"--加载工具
require "Setting.SettingACheck"--加载全局设置

function loadSetting()
	userTargetSettingName=getStringConfig("UserSettingBase","默认设置")
	ui=UI:new()
	option,userSetting=ui:show(userTargetSettingName)
	if option==0 then 
		setting=SettingBase:new()
		sysLog("设置初始化完成共计"..#setting.settings)
		setting:SwitchSetting()
		return loadSetting()
	end
	return true
end


function main()
	--while not loadSetting() do end
	MainForm=Form:new()
	Building={}
	Building.normal=normal:new()
	Building.pandect=pandect:new()
	Building.building=building:new()
	toolBar=ToolBar:new()
	party=party:new()
	ocr=OCR:new()
	ocrInfo=OcrInfo:new()
	Setting.Runtime.ActiveMode.LastActiveTime=os.milliTime()-Setting.Runtime.ActiveMode.Interval*1000
	--GetUserImages(45,2)
	ResetForm()--初始化
	mainLoop()
end

function ResetForm()
	local nowScene=toolBar:GetNowScene()
	if nowScene==3 then
		MainForm:ExitForm(true)
	else if nowScene==2 then
			MainForm:ReturnBase()
		else
			return
		end
	end
	sleep(1000)
end

function mainLoop()
	while true do
		screen.keep(false)
		local thisTime=os.milliTime()
		local activeMode=false
		
		local refreshTimeLeft=math.floor(Setting.Runtime.ActiveMode.Interval-
			(thisTime-Setting.Runtime.ActiveMode.LastActiveTime)/1000)
		if refreshTimeLeft<0 then
			activeMode=true
			Setting.Runtime.ActiveMode.LastActiveTime=thisTime
			ShowInfo.RunningInfo("本轮主动操作开始")
			ResetForm()
		else
			ShowInfo.RunningInfo(string.format("【值勤模式】,%d秒后进行主动操作",refreshTimeLeft),true)
		end
		MainForm:CheckNormalPageTask()
		if activeMode then
			party:NewCheckParty()
		end
		Building.pandect:NewCheckPandect(activeMode)
		
		sleep(500)
		Building.building:Run(activeMode)
		sleep(500)
		if activeMode then
			ResetForm()
		end
	end
end
main()