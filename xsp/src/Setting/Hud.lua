--HUD显示参数
HUD={
	runing = createHUD(),			--用于显示当前状态
	resource = createHUD(),		--资源状态
}
ShowInfo={
	lastRunningInfo="",lastResInfo="",
	RunningInfo=function(info,ingoreLog)
			if ShowInfo.lastRunningInfo~=info then
				if not ingoreLog then 
				sysLog("Running:"..info) end
				ShowInfo.lastRunningInfo=info
				showHUD(HUD.runing,
					info,_userDpi*0.03,"0xffffffff","0x4c000000"
					,0,_fsw*0.5,0,_fsw*0.3,_fsh*0.02)
			end
	end,
	ResInfo=function(info,ingoreLog)
		if info~=ShowInfo.lastResInfo then
			if not ingoreLog then 
			sysLog("resource:"..info) end
			ShowInfo.lastResInfo=info
			showHUD(HUD.resource,
					info,_userDpi*0.03,"0xffffffff","0x4c000000",
					0,_fsw*0.5,_fsh*0.02,_fsw*0.3,_fsh*0.02)
		end
	end
}