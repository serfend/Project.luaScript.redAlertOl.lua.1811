
require "Setting.usingPack"
require "util"--加载工具
require "Setting.SettingACheck"--加载全局设置

function loadSetting()
	ShowInfo.RunningInfo("loadSetting")
	uiHandle:NewDialog("mainSetting",userTargetSettingName)
	while uiHandle:CheckIfNewDialog() do
		sleep(1000)
	end
end


function main()
	wui=require "wui.wui"
	app=Application:new()
	Setting.About.Application=Application.Info--加载更新日志
	uiHandle=UIHandle:new()
	translator=Translator:new()
	encrypt=Encrypt:new()
	ShowInfo.RunningInfo("初始化")
	math.randomseed(os.milliTime())
	MainForm=Form:new()
	Building={}
	Building.normal=normal:new()
	Building.pandect=pandect:new()
	Building.building=CityBuilding:new()
	daily=Daily:new()
	toolBar=ToolBar:new()
	party=party:new()
	ocr=OCR:new()
	ocrInfo=OcrInfo:new()
	LastActiveTime=os.milliTime()-Setting.Runtime.ActiveMode.Interval*1000
	--GetUserImages(45,2)
	ReloadCityIndex()
	mainLoop()
end

function ResetForm()
	ShowInfo.RunningInfo("<恢复状态>")
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
function newConnection()
	ShowInfo.RunningInfo("与服务器建立连接")
	local tryTime=1
	while not uiHandle.InitCheck do
		sleep(2000)
		ShowInfo.RunningInfo(string.format("等待连接到服务器%d/5",tryTime))
		tryTime=tryTime+1 
		if tryTime>5 then
			break
		end
	end
	if uiHandle.InitCheck then
		ShowInfo.RunningInfo("连接成功")
	else
		ShowInfo.RunningInfo("连接失败,离线模式")
		return false
	end
	sleep(1000)
	task.execTimer(100,function()
		connection=TcpClient:new()	
		connection.msgCallBack=msgCallBack
		connection:start()
	end)
end
function mainLoop()
	uiHandle:NewDialog("normalDialogOkCancel",
		"<title>是否开启中控模式</title><info>开启中控模式后,进入:\nhttp://1s68948k74.imwork.net:16397页面进行控制</info>"
	)
	while uiHandle:CheckIfNewDialog() do
		sleep(1000)
	end
	local success=false
	if uiHandle.uiResult=="ok" then
		success=newConnection()
	end
	if not success then
		loadSetting()
	end
	ResetForm()--初始化
	while true do
		newRound()
	end
end
function newRound()
	screen.keep(false)
	if uiHandle:CheckIfNewDialog() then
		ShowInfo.RunningInfo("设置中,暂停操作...")
		return
	end
	local thisTime=os.milliTime()
	local activeMode=false
	local refreshTimeLeft=math.floor(Setting.Runtime.ActiveMode.Interval-
		(thisTime-LastActiveTime)/1000)
	if refreshTimeLeft<0 then
		activeMode=true
		LastActiveTime=thisTime
		ShowInfo.RunningInfo("本轮主动操作开始")
		ResetForm()
	else
		ShowInfo.RunningInfo(string.format("【值勤模式】,%d秒",refreshTimeLeft),true)
	end
	MainForm:CheckNormalPageTask()
	if activeMode then
		party:NewCheckParty()
		daily:NewCheckDaily()
	end
	
	Building.pandect:ResetSetting()
	Building.pandect:NewCheckPandect(activeMode)
	if Building.building:Run(activeMode) then
		sleepWithCheckEnemyConquer(500)
	end
	if activeMode then
		ResetForm()
	end
	sleepWithCheckEnemyConquer(500)
end
main()