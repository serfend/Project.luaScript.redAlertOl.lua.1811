--HUD显示参数
HUD={
	runing = createHUD(),			--用于显示当前状态
	resource = createHUD(),		--资源状态
}
ShowInfo={
	lastRunningInfo="",lastResInfo="",
	RunningInfo=function(info)
			if ShowInfo.lastRunningInfo~=info then
				sysLog("Running:"..info)
				ShowInfo.lastRunningInfo=info
				showHUD(HUD.runing,
					info,_userDpi*0.03,"0xffffffff","0x4c000000"
					,0,_fsw*0.5,0,_fsw*0.3,_fsh*0.02)
			end
	end,
	ResInfo=function(info)
		if info~=ShowInfo.lastResInfo then
			ShowInfo.lastResInfo=info
			sysLog("resource:"..info)
			showHUD(HUD.resource,
					info,_userDpi*0.03,"0xffffffff","0x4c000000",
					0,_fsw*0.5,_fsh*0.02,_fsw*0.3,_fsh*0.02)
		end
	end
}