--@summary:需要根据玩家是否能点击全部开启
function party:RunAttainGift()
	tap(217,1206)
	sleep(500)
	if Setting.Party.Gift.EnableOnekeyAttain then
		ShowInfo.ResInfo("一键领取")
		tap(361,1224)--全部领取
	else
		local none=false
		ShowInfo.ResInfo("逐个领取")
		while not none do
			tap(599,512)--领取第一个
			sleep(200)
			local r,g,b=screen.getRGB(552,529)
			none= not (r>50 and g>50 and b>50)
		end
	end
	MainForm:ExitForm()
end

function party:CheckIfNewGift()
	if not Setting.Party.Gift.Enable then
		return
	end
	local r,g,b=screen.getRGB(253,1170)--礼品信息点
	if  (r>200 and g<100 and b<100) then
		return function()
			self:RunAttainGift()
		end
	end
	return false
end