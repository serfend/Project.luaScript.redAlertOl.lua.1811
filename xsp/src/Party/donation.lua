local canUpdateTime=0
function party:CheckIfDonation()
	if not Setting.Party.Donation.Enable then
		return false
	end
	canUpdateTime=self:GetNowDonateTimes()
	if canUpdateTime then
		if canUpdateTime>Setting.Party.Donation.MinDonateTime then
			return function()
				self:DonateAll(canUpdateTime)
			end
		else
			ShowInfo.ResInfo(string.format("当前捐献:%d/%d",canUpdateTime,Setting.Party.Donation.MinDonateTime))
			return false
		end
	else
		ShowInfo.ResInfo("当前次数识别失败")
	end
end

--@summary:获取当前可捐献的次数
function party:GetNowDonateTimes()
	local times=ocrInfo:GetNowPartyDonationTime(153,746,28,22)
	return tonumber(times)
end


--@summary:进行全部捐献	
function party:DonateAll(times)
	ShowInfo.ResInfo("联盟捐献%d次",times)
	tap(118,698)
	sleep(1000)
	local point = screen.findColor(Rect(244, 328, 140, 874), 
"0|0|0xffefa1,3|0|0x52565a",
95, screen.PRIORITY_DEFAULT)--半颗星
	if point.x<0 then
		point = screen.findColor(Rect(244, 328, 140, 874), 
"0|0|0x53575c,0|-4|0x53575c,3|-4|0x53575c,4|-1|0x53575c",
95, screen.PRIORITY_DEFAULT)--无星
		if point.x<0 then
			ShowInfo.ResInfo("当前暂无可升级科技")
		else
			self:DonateStart(times,point)
		end
	else
		self:DonateStart(times,point)
	end
	MainForm:ExitForm()--返回上一层
end

function party:DonateStart(times,point)
	tap(point.x-50,point.y-10)
	sleep(800)
	for i=1,times do
		tap(508,895)
		sleep(300)
	end
	ShowInfo.ResInfo(string.format("已完成捐献%d此",times))
end