require "Setting.usingPack"
require "Setting.UserSettingBase"
require "util"--加载工具
require "Setting.SettingACheck"--加载全局设置

function loadSetting()
	userTargetSettingName=storage.get("UserSettingBase","默认设置")
	ui=sfUI:new()
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
	wui=require "wui.wui"
	app=Application:new()
	uiHandle=UIHandle:new()
	encrypt=Encrypt:new()
	ShowInfo.RunningInfo("初始化")
	math.randomseed(os.milliTime())
	--while not loadSetting() do end
	MainForm=Form:new()
	Building={}
	Building.normal=normal:new()
	Building.pandect=pandect:new()
	Building.building=CityBuilding:new()
	toolBar=ToolBar:new()
	party=party:new()
	ocr=OCR:new()
	ocrInfo=OcrInfo:new()
	Setting.Runtime.ActiveMode.LastActiveTime=os.milliTime()-Setting.Runtime.ActiveMode.Interval*1000
	--GetUserImages(45,2)
	
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

function mainLoop()
	ShowInfo.RunningInfo("与服务器建立连接")
	connection=TcpClient:new()	
	connection.msgCallBack=msgCallBack
	connection:start()
--	connection:send("AllSetting",formatTable(Setting))
	while not uiHandle.InitCheck do
		sleep(1000)
		ShowInfo.RunningInfo("等待连接到服务器")
	end
	ShowInfo.RunningInfo("连接成功")
	sleep(1000)
	uiHandle:CheckIfNewDialog()
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
	
	if normal.InDanger then
		ShowInfo.RunningInfo("【防御模式】")
	else
		local refreshTimeLeft=math.floor(Setting.Runtime.ActiveMode.Interval-
			(thisTime-Setting.Runtime.ActiveMode.LastActiveTime)/1000)
		if refreshTimeLeft<0 then
			activeMode=true
			Setting.Runtime.ActiveMode.LastActiveTime=thisTime
			ShowInfo.RunningInfo("本轮主动操作开始")
			ResetForm()
		else
			ShowInfo.RunningInfo(string.format("【值勤模式】,%d秒",refreshTimeLeft),true)
		end
	end
	MainForm:CheckNormalPageTask()
	if not normal.InDanger then
		if activeMode then
			party:NewCheckParty()
		end
		
		Building.pandect:ResetSetting()
		Building.pandect:NewCheckPandect(activeMode)
		if Building.building:Run(activeMode) then
			sleep(500)
		end
		if activeMode then
			ResetForm()
		end
	end
end
main()