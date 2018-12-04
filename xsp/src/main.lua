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

function msgCallBack(msg)
	print("来自服务器:"..msg)
	if string.contains(msg,"<SetSetting>") then
		local list=string.GetAllElement(msg,"<setting>","</setting>")
		for i,v in ipairs(list) do
			local key=string.GetElement(v,"<key>","</key>")
			local value=string.GetElement(v,"<value>","</value>")
			local tmp=split(key,".")--设置.子设置.子子设置
			local rawSet=Setting
			for j=1,#tmp-1 do
				rawSet=rawSet[v2]
			end
			local checkNumber=tonumber(tmp[#tmp])--判断最后一项是否为数字
			if checkNumber then
				rawSet[checkNumber]=value
			else
				rawSet[tmp[#tmp]]=value
			end
		end
	end
	if string.contains(msg,"<GetAllSetting>") then
		connection:send("AllSetting",formatTable(Setting))
	end
end
function main()
	encrypt=Encrypt:new()
	connection=TcpClient:new()
	connection.msgCallBack=msgCallBack
	connection:start()
--	connection:send("AllSetting",formatTable(Setting))
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
	Building.building:Navigate("特惠商人")
	while true do
		screen.keep(false)
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
				ShowInfo.RunningInfo("<恢复状态>")
				ResetForm()
			end
		end
		
	end
end
main()