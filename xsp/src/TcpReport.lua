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
	swip(555,555,555,1200,5)
	sleep(500)
end

function 结算按钮(psw)
	tap(740	,1672)
	mSleep(300)
	tap(655,1850)
	connection:send({Title="rpNormalMessage",Content="等待餘額按鈕"})
	while true do
		local r,g,b=screen.getRGB(122,1834)
		if r>200 and g<100 and b<100 then
			tap(122,1834)--点击余额付款按钮
			break
		end
	end
	connection:send({Title="rpNormalMessage",Content="輸入密碼"})
	while true do
		local r,g,b=screen.getRGB(144,657)
		if r>240 and g>240 and b>240 then
			--白色付款框
			sleep(200)
			InputPsw(psw)
			break
		end
	end
	connection:send({Title="rpNormalMessage",Content="完成付款"})
end
function InputPsw(psw)
	if string.len(psw)==6 then
	else
		dialog("233")
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