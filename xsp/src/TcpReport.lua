function msgCallBack(msg)
	print("来自服务器:"..formatTable(msg))
	if msg.Title=="cmdPayCurrentBill" then
		ShowInfo.RunningInfo("開始付款")
		connection:send({Title="rpNormalMessage",Content="開始付款"})
		RefreshBill()
		connection:send({Title="rpNormalMessage",Content="結算按鈕"})
		结算按钮(msg.Psw or "121212")
	end
end

function RefreshBill()
	swip(555,555,455,1200)
end

function 结算按钮(psw)
	
	local tryTime=0
	connection:send({Title="rpNormalMessage",Content="等待付款按钮出现"})
	while true do
		local r,g,b=screen.getRGB(740,1672)
		if r>200 and b<200 and g<200 then
			break
		end
		mSleep(100)
	end
	tap(740	,1672)
	connection:send({Title="rpNormalMessage",Content="等待跳转"})
	while true do
		local r,g,b=screen.getRGB(870,1850)
		if r>200 and b<200 and g<200 then
			break
		end
		mSleep(100)
	end
	screen.keep(true)
	for i=900,1500 do
		local r,g,b=screen.getRGB(50,i)
		if r>200 and g<200 and b<200 then--余额按钮
			local r,g,b=screen.getRGB(50,i+5)
			if r>200 and g<200 and b<200 then--余额按钮
				tap(50,i+5)
				sleep(100)
				break
			end
		end
	end
	screen.keep(false)
	tap(870,1850)
	connection:send({Title="rpNormalMessage",Content="等待余额按钮"})
	local startTime=os.milliTime()
	while os.milliTime()-startTime<10000 do
		sleep(10)
		local r,g,b=screen.getRGB(122,1834)
		if r>200 and g<100 and b<100 then
			tap(122,1834)--点击余额付款按钮
			break
		end
	end
	connection:send({Title="rpNormalMessage",Content="輸入密碼"})
	startTime=os.milliTime()
	while os.milliTime()-startTime<10000 do
		sleep(10)
		local r,g,b=screen.getRGB(144,657)
		if r>240 and g>240 and b>240 then
			--白色付款框
			sleep(500)
			InputPsw(psw)
			break
		end
	end
	if os.milliTime()-startTime<3000 then
		connection:send({Title="rpNormalMessage",Content="完成付款"})
	else
		connection:send({Title="rpNormalMessage",Content="付款失败，请返回"})
	end
end
function InputPsw(psw)
	if string.len(psw)==6 then
	else
		dialog("密码位数不正确"..psw)
	end
	for i=1,6 do
		local thisChr=string.sub(psw,i,i)
		print(thisChr)
		if thisChr=="1" then
			tap(190,1393)
		elseif thisChr=="2" then
			tap(543,1392)
		elseif thisChr=="3" then
			tap(896,1392)
		elseif thisChr=="4" then
			tap(187,1548)
		elseif thisChr=="5" then
			tap(543,1548)
		elseif thisChr=="6" then
			tap(896,1548)
		elseif thisChr=="7" then
			tap(187,1696)
		elseif thisChr=="8" then
			tap(543,1696)
		elseif thisChr=="9" then
			tap(896,1696)
		elseif thisChr=="0" then
			tap(543,1847)
		end
	end
end